import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const SplashScreen({super.key, required this.onFinished});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _BallState {
  final double dy; // vertical offset (negative = up)
  final double squash; // 0 = round, 1 = max squash on impact

  const _BallState(this.dy, this.squash);
}

/// A moment where the ball hits the ground.
class _Impact {
  final double p; // ball progress (0..1) at the moment of impact
  final double strength; // 0..1, how hard the hit is

  const _Impact(this.p, this.strength);
}

/// Horizontal roll progress for ball progress [p] (0..1).
/// Quadratic ease-out: keeps rolling through the bounces, then stops gently.
double _roll(double p) => 1 - (1 - p) * (1 - p);

double _clamp01(double v) => math.max(0.0, math.min(1.0, v));

/// Paints small dust puffs on the ground where the ball has landed.
class _DustPainter extends CustomPainter {
  final List<_Impact> impacts;
  final double progress; // UNclamped ball progress (can go past 1)
  final double travel;

  // How long a puff lives, in ball-progress units.
  static const double _span = 0.10;

  _DustPainter({
    required this.impacts,
    required this.progress,
    required this.travel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final groundY = size.height;

    for (final impact in impacts) {
      final age = (progress - impact.p) / _span;
      if (age <= 0 || age >= 1) continue;

      // Dust stays where the ball landed (it does not travel with the ball).
      final cx = size.width / 2 - travel * (1 - _roll(impact.p));
      final t = Curves.easeOut.transform(age);
      final fade = 1 - age;
      final s = 0.35 + 0.65 * impact.strength;

      for (int j = 0; j < 6; j++) {
        final side = j.isEven ? -1.0 : 1.0;
        final layer = j ~/ 2; // 0, 1, 2

        final x = cx + side * (6 + (18 + layer * 10) * t) * s;
        final y = groundY - (2 + (6 + layer * 6) * t) * s;
        final r = (3 + layer * 1.5 + 6 * t) * s;

        final paint = Paint()
          ..color = Colors.white.withOpacity(
            0.35 * fade * (0.5 + 0.5 * impact.strength),
          )
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

        canvas.drawCircle(Offset(x, y), r, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DustPainter old) =>
      old.progress != progress || old.travel != travel;
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late List<Animation<double>> _letterOpacity;
  late List<Animation<double>> _letterTravel; // 0 = inside ball, 1 = final spot
  late List<Animation<double>> _letterScale;

  late final Animation<double> _ballFade;
  late final Animation<double> _centerShift;
  late final Animation<double> _shimmer;
  late final Animation<double> _glow;
  late final Animation<double> _tagline;

  final String logo = 'FUTHUB';

  static const Color _accent = Color(0xFF00E676);

  static const double _ballSize = 100;
  static const double _gap = 12;

  // ---------------------------------------------------------------------------
  // Timeline (fractions of the whole animation, 0..1)
  //
  //   0.00 - 0.46  ball rolls in and bounces (dust + haptics on each landing)
  //   0.52 - 0.82  letters come out of the ball, one by one
  //   0.78 - 0.86  ball fades away
  //   0.78 - 0.90  logo glides to the center of the screen
  //   0.84 - 0.94  shimmer sweeps across the logo
  //   0.86 - 0.95  tagline fades in
  //   0.95 - 1.00  short hold, then onFinished
  // ---------------------------------------------------------------------------
  static const double _ballPhaseEnd = 0.46;

  static const double _lettersStart = 0.52;
  static const double _letterStagger = 0.04;
  static const double _letterDuration = 0.10;

  static const double _ballFadeStart = 0.78;
  static const double _ballFadeEnd = 0.86;
  static const double _shiftStart = 0.78;
  static const double _shiftEnd = 0.90;
  static const double _shimmerStart = 0.84;
  static const double _shimmerEnd = 0.94;
  static const double _taglineStart = 0.86;
  static const double _taglineEnd = 0.95;

  // Peak height of each bounce (px). Each bounce is lower, like real energy loss.
  static const List<double> _bounceHeights = [110, 48, 20, 7];

  // Letter widths are measured once (lazily) and cached.
  late final List<double> _letterWidths = _measureLetters();

  // Ground impacts (for dust and haptics), computed once.
  late final List<_Impact> _impacts = _computeImpacts();
  int _nextImpact = 0;

  /// Start time (0..1 of the controller) for letter [i].
  double _start(int i) => _lettersStart + (i * _letterStagger);

  TextStyle _logoStyle({bool shadows = true}) => GoogleFonts.poppins(
        fontSize: 44,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        letterSpacing: 3,
        shadows: shadows
            ? [
                Shadow(color: Colors.white.withOpacity(0.35), blurRadius: 14),
                const Shadow(
                  color: Colors.black54,
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ]
            : null,
      );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5500),
    );

    // Quick fade-in right as the letter leaves the ball.
    _letterOpacity = List.generate(logo.length, (i) {
      final s = _start(i);
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(s, s + 0.04, curve: Curves.easeOut),
      );
    });

    // Position: 0 = at the ball's center, 1 = final spot.
    _letterTravel = List.generate(logo.length, (i) {
      final s = _start(i);
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(s, s + _letterDuration, curve: Curves.easeOutCubic),
      );
    });

    // Small pop while sliding out.
    _letterScale = List.generate(logo.length, (i) {
      final s = _start(i);
      return Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(s, s + _letterDuration, curve: Curves.easeOutBack),
        ),
      );
    });

    _ballFade = CurvedAnimation(
      parent: _controller,
      curve: Interval(_ballFadeStart, _ballFadeEnd, curve: Curves.easeIn),
    );

    _centerShift = CurvedAnimation(
      parent: _controller,
      curve: Interval(_shiftStart, _shiftEnd, curve: Curves.easeInOutCubic),
    );

    _shimmer = CurvedAnimation(
      parent: _controller,
      curve: Interval(_shimmerStart, _shimmerEnd, curve: Curves.easeInOut),
    );

    _glow = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.48, 0.85, curve: Curves.easeOut),
    );

    _tagline = CurvedAnimation(
      parent: _controller,
      curve: Interval(_taglineStart, _taglineEnd, curve: Curves.easeOut),
    );

    _controller.addListener(_onTick);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        widget.onFinished();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Fires a haptic tap every time the ball hits the ground.
  void _onTick() {
    final p = _controller.value / _ballPhaseEnd;
    while (_nextImpact < _impacts.length && p >= _impacts[_nextImpact].p) {
      final s = _impacts[_nextImpact].strength;
      if (s > 0.6) {
        HapticFeedback.mediumImpact();
      } else if (s > 0.3) {
        HapticFeedback.lightImpact();
      } else {
        HapticFeedback.selectionClick();
      }
      _nextImpact++;
    }
  }

  List<_Impact> _computeImpacts() {
    final weights = _bounceHeights.map((h) => math.sqrt(h)).toList();
    final total = weights.reduce((a, b) => a + b);

    double acc = 0;
    final out = <_Impact>[];
    for (int i = 0; i < _bounceHeights.length; i++) {
      acc += weights[i] / total;
      final isLast = i == _bounceHeights.length - 1;
      out.add(
        _Impact(
          isLast ? 1.0 : acc,
          math.sqrt(_bounceHeights[i] / _bounceHeights[0]),
        ),
      );
    }
    return out;
  }

  /// Computes the ball's height and squash for ball progress [p] (0..1).
  /// Flight time of a bounce is proportional to sqrt(height), like real gravity,
  /// and each arc is a parabola.
  _BallState _ballState(double p) {
    final weights = _bounceHeights.map((h) => math.sqrt(h)).toList();
    final total = weights.reduce((a, b) => a + b);

    const contactWindow =
        0.04; // time (in ball progress) of the squash on impact
    double start = 0;

    for (int i = 0; i < _bounceHeights.length; i++) {
      final span = weights[i] / total;
      final isLast = i == _bounceHeights.length - 1;

      if (p <= start + span || isLast) {
        final q = ((p - start) / span).clamp(0.0, 1.0);
        final h = _bounceHeights[i];
        final dy = -h * 4 * q * (1 - q);

        final w = math.min(contactWindow / span, 0.35);
        double contact = 0;
        double strength = 0;

        // Squash right after landing from the previous bounce.
        if (i > 0 && q < w) {
          contact = 1 - q / w;
          strength = math.sqrt(_bounceHeights[i - 1] / _bounceHeights[0]);
        }
        // Squash right before landing (not for the final settle).
        if (!isLast && q > 1 - w) {
          contact = 1 - (1 - q) / w;
          strength = math.sqrt(h / _bounceHeights[0]);
        }

        return _BallState(dy, contact * strength);
      }
      start += span;
    }
    return const _BallState(0, 0);
  }

  /// Shadow width: widest on the ground (and a bit wider on impact),
  /// shrinking as the ball goes up.
  double _shadowWidth(double heightFactor, double squash) {
    final base = _ballSize * (0.45 + 0.45 * heightFactor);
    return base * (1 + 0.12 * squash);
  }

  /// A flat, soft-edged white ellipse (radial gradient squashed vertically).
  Widget _shadowEllipse({required double width, required double opacity}) {
    final o = opacity.clamp(0.0, 1.0);
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(
        1,
        0.22,
        1,
      ), // flatten circle -> ellipse
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.white.withOpacity(o),
              Colors.white.withOpacity(o * 0.45),
              Colors.white.withOpacity(0),
            ],
            stops: const [0.0, 0.55, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildBall(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final travel = screenWidth / 2 + _ballSize + 40; // starts fully off-screen
    const radius = _ballSize / 2;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final raw = _controller.value / _ballPhaseEnd; // can go past 1
        final p = raw.clamp(0.0, 1.0);

        // Ball keeps rolling while it bounces, then comes to a gentle stop.
        final eased = _roll(p);
        final dx = -travel * (1 - eased);

        // Rolling without slipping: angle = distance / radius.
        final angle = (travel * eased) / radius;

        final state = _ballState(p);
        final height = -state.dy;
        final heightFactor = 1 - (height / _bounceHeights[0]).clamp(0.0, 1.0);

        final scaleX = 1 + 0.14 * state.squash;
        final scaleY = 1 - 0.22 * state.squash;

        final fade = _ballFade.value;

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            // Dust puffs where the ball has landed (stay on the ground).
            CustomPaint(
              size: const Size(_ballSize, _ballSize),
              painter: _DustPainter(
                impacts: _impacts,
                progress: raw,
                travel: travel,
              ),
            ),

            // The ball itself. Fades and shrinks away once the letters are out.
            Opacity(
              opacity: (1 - fade).clamp(0.0, 1.0),
              child: Transform.scale(
                scale: 1 - 0.35 * fade,
                child: Transform.translate(
                  offset: Offset(dx, 0),
                  child: SizedBox(
                    width: _ballSize,
                    height: _ballSize,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Realistic ground shadow (white): soft outer penumbra
                        // + tight contact core. Reacts to ball height.
                        Positioned(
                          bottom:
                              -(_shadowWidth(heightFactor, state.squash) / 2),
                          child: IgnorePointer(
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                // Outer soft shadow
                                _shadowEllipse(
                                  width: _shadowWidth(
                                    heightFactor,
                                    state.squash,
                                  ),
                                  opacity: 0.10 + 0.30 * heightFactor,
                                ),
                                // Inner dense contact shadow
                                _shadowEllipse(
                                  width: _shadowWidth(
                                        heightFactor,
                                        state.squash,
                                      ) *
                                      0.5,
                                  opacity: 0.05 +
                                      0.45 * heightFactor * heightFactor,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Ball: bounce (translate) -> squash (anchored at
                        // bottom) -> spin
                        Transform.translate(
                          offset: Offset(0, state.dy),
                          child: Transform(
                            alignment: Alignment.bottomCenter,
                            transform:
                                Matrix4.diagonal3Values(scaleX, scaleY, 1),
                            child: Transform.rotate(
                              angle: angle,
                              child: Image.asset(
                                'assets/images/football.png',
                                width: _ballSize,
                                height: _ballSize,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Measures each letter's width so we know how far it must travel
  /// from the ball's center to its final position.
  List<double> _measureLetters() {
    return logo.split('').map((ch) {
      final tp = TextPainter(
        text: TextSpan(text: ch, style: _logoStyle(shadows: false)),
        textDirection: TextDirection.ltr,
      )..layout();
      return tp.width;
    }).toList();
  }

  /// One row of animated letters. It starts with a spacer the size of the
  /// ball, so the row's box also covers the ball area (this keeps the shader
  /// masks below from clipping letters while they travel out of the ball).
  Widget _lettersRow(TextStyle style) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        double xCursor = 0; // left edge of the current letter within the text
        final children = <Widget>[const SizedBox(width: _ballSize + _gap)];

        for (int i = 0; i < logo.length; i++) {
          final w = _letterWidths[i];

          // Distance from the ball's center to this letter's final center.
          final distance = (_ballSize / 2) + _gap + xCursor + w / 2;
          xCursor += w;

          final dx = -distance * (1 - _letterTravel[i].value);

          children.add(
            Opacity(
              opacity: _letterOpacity[i].value.clamp(0.0, 1.0),
              child: Transform.translate(
                offset: Offset(dx, 0),
                child: Transform.scale(
                  scale: _letterScale[i].value,
                  child: Text(logo[i], style: style),
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(mainAxisSize: MainAxisSize.min, children: children),
        );
      },
    );
  }

  /// White -> mint -> green brand gradient across the letters only.
  Shader _brandShader(Rect b) {
    final a = (_ballSize + _gap) / b.width;
    double at(double f) => a + (1 - a) * f;

    return LinearGradient(
      colors: const [
        Colors.white,
        Colors.white,
        Color(0xFF7CFFB2),
        _accent,
      ],
      stops: [0.0, at(0.45), at(0.8), 1.0],
    ).createShader(b);
  }

  /// A bright diagonal band that sweeps left -> right as [t] goes 0 -> 1.
  Shader _shimmerShader(Rect b, double t) {
    final a = (_ballSize + _gap) / b.width;
    final center = a + (1 - a) * (-0.25 + 1.5 * t);

    return LinearGradient(
      begin: const Alignment(-1, -0.4),
      end: const Alignment(1, 0.4),
      colors: [
        Colors.white.withOpacity(0),
        Colors.white.withOpacity(0.9),
        Colors.white.withOpacity(0),
      ],
      stops: [
        _clamp01(center - 0.1),
        _clamp01(center),
        _clamp01(center + 0.1),
      ],
    ).createShader(b);
  }

  /// The logo text, built from three stacked layers:
  /// 1) glow + drop shadow, 2) gradient fill, 3) shimmer sweep.
  Widget _buildLogoText() {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: [
        // 1) Glow / shadow only (the fill itself is transparent).
        _lettersRow(_logoStyle().copyWith(color: Colors.transparent)),

        // 2) Gradient fill.
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: _brandShader,
          child: _lettersRow(_logoStyle(shadows: false)),
        ),

        // 3) Shimmer sweep (only exists while it is running).
        AnimatedBuilder(
          animation: _shimmer,
          builder: (context, _) {
            final t = _shimmer.value;
            if (t <= 0 || t >= 1) return const SizedBox.shrink();
            return ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (b) => _shimmerShader(b, t),
              child: _lettersRow(_logoStyle(shadows: false)),
            );
          },
        ),
      ],
    );
  }

  /// Soft green spotlight behind the logo that fades in and gently pulses.
  Widget _buildGlow() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final pulse = 0.9 + 0.1 * math.sin(_controller.value * math.pi * 8);
        final a = 0.22 * _glow.value * pulse;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 0.75,
              colors: [
                _accent.withOpacity(a),
                _accent.withOpacity(a * 0.35),
                _accent.withOpacity(0),
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagline() {
    return AnimatedBuilder(
      animation: _tagline,
      builder: (context, _) {
        final t = _tagline.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - t)),
            child: Text(
              'YOUR FOOTBALL HUB',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 6,
                color: Colors.white70,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050706),
      body: Stack(
        children: [
          // Background glow.
          Positioned.fill(child: IgnorePointer(child: _buildGlow())),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo group. After the ball fades, it glides left so the
                // letters end up exactly centered on the screen.
                AnimatedBuilder(
                  animation: _centerShift,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        -(_ballSize + _gap) / 2 * _centerShift.value,
                        0,
                      ),
                      child: child,
                    );
                  },
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.none,
                    children: [
                      // Letters first = painted BEHIND the ball.
                      _buildLogoText(),
                      // Ball last = painted on top, hiding the letters until
                      // they slide out.
                      _buildBall(context),
                    ],
                  ),
                ),

                const SizedBox(height: 14),
                _buildTagline(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}