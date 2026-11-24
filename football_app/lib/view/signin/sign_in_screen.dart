import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/config/routes/route_names.dart';
import 'package:football_app/view/signin/widgets/email_input_widget.dart';
import 'package:football_app/view/signin/widgets/login_button_widget.dart';
import 'package:football_app/view/signin/widgets/password_input_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

const _kAccent = Color(0xFFB7F34A);

class SignInScreen extends StatefulWidget {
  final bool showBack;
  const SignInScreen({super.key, this.showBack = false});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    final bloc = context.read<AuthBloc>();
    if (bloc.state.isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    bloc.add(
      AuthEvent.loginRequested(
        email: _email.text.trim(),
        password: _password.text,
      ),
    );
  }

  void _google() {
    final bloc = context.read<AuthBloc>();
    if (bloc.state.isLoading) return;
    FocusScope.of(context).unfocus();
    bloc.add(const AuthEvent.googleSignInRequested());
  }

  void _openSignup() => context.push(RouteNames.signUp);
  void _openForgotPassword() => context.push(RouteNames.forgotPassword);
  void _onState(BuildContext context, AuthState state) {
    // SignupScreen may be pushed on top: only the visible screen reacts.
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;
    final message = state.message;
    if (message == null) return;

    // Same hint for every failed login, so it reveals nothing about any account.
    final isBadCredentials =
        state.status == AuthStatus.failure &&
        message.toLowerCase().contains('invalid email or password');

    _showError(
      context,
      message,
      hint: isBadCredentials
          ? 'Signed up with Google? Use Continue with Google, or tap Forgot Password.'
          : null,
      onGoogle: isBadCredentials ? _google : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) =>
          c.status == AuthStatus.failure ||
          (c.status == AuthStatus.unauthenticated && c.message != null),
      listener: _onState,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/login_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.45)),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (p, c) =>
                              p.status != c.status || p.method != c.method,
                          builder: (context, state) {
                            final busy = state.isLoading;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Hello!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Sign in to your account',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 50),
                                IgnorePointer(
                                  ignoring: busy,
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 150),
                                    opacity: busy ? 0.6 : 1,
                                    child: Column(
                                      children: [
                                        EmailInputWidget(controller: _email),
                                        const SizedBox(height: 15),
                                        PasswordInputWidget(
                                          controller: _password,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: busy ? null : _openForgotPassword,
                                      child: Text(
                                        'Forgot Password?',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                LoginButtonWidget(
                                  onPressed: _login,
                                  isLoading: state.isEmailLoading,
                                ),
                                const SizedBox(height: 30),
                                const _OrDivider(text: 'Or sign in with'),
                                const SizedBox(height: 25),
                                _GoogleButton(
                                  loading: state.isGoogleLoading,
                                  onPressed: busy ? null : _google,
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account? ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: busy ? null : _openSignup,
                                      child: Text(
                                        'Sign Up',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: _kAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // NEW: back arrow, only when opened from Become Organizer.
            // Last child of the Stack so it sits on top and can be tapped.
            if (widget.showBack)
              Positioned(
                top: 0,
                left: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void _showError(
  BuildContext context,
  String message, {
  String? hint,
  VoidCallback? onGoogle,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: hint == null ? 4 : 7),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message, style: GoogleFonts.poppins(fontSize: 13)),
            if (hint != null) ...[
              const SizedBox(height: 4),
              Text(
                hint,
                style: GoogleFonts.poppins(fontSize: 11, color: Colors.white70),
              ),
            ],
          ],
        ),
        action: onGoogle == null
            ? null
            : SnackBarAction(
                label: 'GOOGLE',
                textColor: Colors.white,
                onPressed: onGoogle,
              ),
      ),
    );
}

class _OrDivider extends StatelessWidget {
  final String text;
  const _OrDivider({required this.text});

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: Divider(color: Colors.white.withValues(alpha: 0.3)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          line,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
            ),
          ),
          line,
        ],
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;
  const _GoogleButton({required this.loading, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            disabledBackgroundColor: Colors.white70,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: loading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black87,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'G',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4285F4),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Google',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}