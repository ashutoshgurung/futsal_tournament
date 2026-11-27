import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/config/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shows [child] only when logged in. Guests see a sign in prompt instead.
class GuestGate extends StatelessWidget {
  final Widget child;
  final String title;
  final String message;

  const GuestGate({
    super.key,
    required this.child,
    this.title = 'Your profile',
    this.message = 'Sign in to manage your account and see your details.',
  });

  static const _green = Color(0xFF10D876); // change to match your theme

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) {
        if (state.status == AuthStatus.success) return child;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Big faded football in the top right corner
              const Positioned(
                top: -30,
                right: -90,
                child: Icon(
                  Icons.sports_soccer,
                  size: 330,
                  color: Color(0x0FFFFFFF), // white at about 6%
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        message,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () => context.push(RouteNames.signIn),
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: TextButton(
                          onPressed: () => context.push(RouteNames.signIn),
                          child: Text(
                            'Create an account',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}