import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/view/bottom_navigation/bottom_navigation_screen.dart';
import 'package:football_app/view/forget_password/forget_password_screen.dart';
import 'package:football_app/view/signin/widgets/email_input_widget.dart';
import 'package:football_app/view/signin/widgets/login_button_widget.dart';
import 'package:football_app/view/signin/widgets/password_input_widget.dart';
import 'package:football_app/view/signup/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<AuthBloc>().add(
      AuthEvent.loginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const BottomNavigationScreen()),
            (route) => false,
          );
        } else if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Something went wrong'),
                backgroundColor: Colors.red.shade700,
              ),
            );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;

        return Scaffold(
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
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hello!",
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Sign in to your account",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 50),

                                EmailInputWidget(controller: _emailController),
                                const SizedBox(height: 15),
                                PasswordInputWidget(
                                  controller: _passwordController,
                                ),
                                const SizedBox(height: 15),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ForgetPasswordScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Forgot Password?",
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
                                  isLoading: isLoading,
                                  onPressed: _submit,
                                ),
                                const SizedBox(height: 30),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Divider(
                                          color: Colors.white38,
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          "Or sign up with",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        child: Divider(
                                          color: Colors.white38,
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 25),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Container(
                                    height: 55,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/google_icon.png",
                                          height: 22,
                                          width: 22,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          "Continue with Google",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => SignupScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFB7F34A),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
