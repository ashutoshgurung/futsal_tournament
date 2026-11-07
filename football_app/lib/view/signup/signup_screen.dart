import 'package:flutter/material.dart';
import 'package:football_app/view/signin/sign_in_screen.dart';
import 'package:football_app/view/signup/widgets/custom_textfield_widget.dart';
import 'package:football_app/view/signup/widgets/signup_button_widget.dart';
import 'package:football_app/view/signup/widgets/terms_checkbox_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmFocusNode = FocusNode();

  bool _agreedToTerms = false;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(
                "assets/images/futbookok.png",
                height: 150,
                width: 250,
                color: Colors.white,
              ),
              Text(
                "Get Started",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter your details below",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: 'Email address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
                focusNode: _passwordFocusNode,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: 'Confirm password',
                icon: Icons.lock_outline,
                isPassword: true,
                focusNode: _confirmFocusNode,
              ),
              const SizedBox(height: 16),
              TermsCheckbox(
                value: _agreedToTerms,
                onChanged: (v) => setState(() => _agreedToTerms = v),
              ),
              const SizedBox(height: 20),
              SignUpButton(onPressed: () {}),
              const SizedBox(height: 30),

              // Divider with text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(color: Colors.white38, thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Or sign up with",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: Colors.white38, thickness: 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignInScreen()),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFB7F34A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
