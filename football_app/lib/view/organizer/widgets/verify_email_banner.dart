import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/repository/auth/auth_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailBanner extends StatefulWidget {
  const VerifyEmailBanner({super.key});

  @override
  State<VerifyEmailBanner> createState() => _VerifyEmailBannerState();
}

class _VerifyEmailBannerState extends State<VerifyEmailBanner>
    with WidgetsBindingObserver {
  bool _sending = false;
  DateTime? _lastSent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // User tapped the email link in the browser and came back to the app:
  // reload /auth/me so emailVerified updates and the banner disappears.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  void _refresh() {
    context.read<AuthBloc>().add(const AuthEvent.appStarted());
  }

  void _snack(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error ? Colors.redAccent : Colors.green,
        content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
      ),
    );
  }

  Future<void> _resend(String email) async {
    // Simple 60s cooldown so the button can't be spammed
    if (_lastSent != null &&
        DateTime.now().difference(_lastSent!) < const Duration(seconds: 60)) {
      _snack(
        'Please wait a minute before requesting another email.',
        error: true,
      );
      return;
    }

    setState(() => _sending = true);
    try {
      final msg = await context.read<AuthRepository>().resendVerification(
        email,
      );
      _lastSent = DateTime.now();
      _snack(msg ?? 'Verification email sent.');
    } catch (_) {
      _snack('Could not send the email. Try again later.', error: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (p, c) => p.session != c.session,
      builder: (context, state) {
        final user = state.session?.user;
        if (user == null || user['emailVerified'] == true) {
          return const SizedBox.shrink();
        }
        final email = (user['email'] as String?) ?? '';

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.orangeAccent.withValues(alpha: 0.6),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.mark_email_unread_outlined,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Verify your email',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'We sent a link to $email. Verify it so you can log in again later and publish tournaments.',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: _sending ? null : () => _resend(email),
                    child: _sending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Resend email',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                  ),
                  TextButton(
                    onPressed: _refresh,
                    child: Text(
                      "I've verified",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
