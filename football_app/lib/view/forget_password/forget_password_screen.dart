import 'package:flutter/material.dart';
import 'package:football_app/view/forget_password/forget_password_instruction_screen.dart';
import 'package:football_app/view/forget_password/widgets/f_email_input_widget.dart';
import 'package:football_app/view/forget_password/widgets/f_send_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Forget Password",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Image.asset("assets/icons/lock.png", height: 100, width: 100),

                const SizedBox(height: 20),

                Text(
                  "Forget your password?",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Enter your registered email below to receive",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
                ),

                const SizedBox(height: 5),

                Text(
                  "password reset instruction",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                const FEmailInputWidget(),
                const SizedBox(height: 25),
                FSendWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ForgetPasswordInstructionScreen(),
                      ),
                    );
                  },
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You remember your password?",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        " Sign in",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFFB7F34A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
