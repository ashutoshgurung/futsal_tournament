import 'package:flutter/material.dart';
import 'package:football_app/view/login/widgets/email_input_widget.dart';
import 'package:football_app/view/login/widgets/login_button_widget.dart';
import 'package:football_app/view/login/widgets/password_input_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_image.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.45)),
          ),

          // Login UI
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
                            // Heading
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

                            // Email
                            const EmailInputWidget(),

                            const SizedBox(height: 15),

                            // Password
                            const PasswordInputWidget(),

                            const SizedBox(height: 12),

                            // Forgot password
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
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

                            const SizedBox(height: 25),

                            // Login button
                            LoginButtonWidget(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Dispatch your login BLoC event here.
                                }
                              },
                            ),

                            const SizedBox(height: 30),

                            // Divider with text
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                            // SizedBox(height: 20),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //     horizontal: 15.0,
                            //   ),
                            //   child: Container(
                            //     height: 55,
                            //     width: double.maxFinite,
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(50),
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Image.asset(
                            //           "assets/icons/google_icon.png",
                            //           height: 22,
                            //           width: 22,
                            //         ),
                            //         const SizedBox(width: 12),
                            //         Text(
                            //           "Continue with Google",
                            //           style: GoogleFonts.poppins(
                            //             fontSize: 14,
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 40),
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
                                GestureDetector(
                                  onTap: () {},
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
  }
}
