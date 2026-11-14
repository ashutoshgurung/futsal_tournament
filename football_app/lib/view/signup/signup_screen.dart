import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
// Adjust these three paths to where your widgets live.
import 'package:football_app/view/signup/widgets/custom_textfield_widget.dart';
import 'package:football_app/view/signup/widgets/signup_button_widget.dart';
import 'package:football_app/view/signup/widgets/terms_checkbox_widget.dart';
import 'package:google_fonts/google_fonts.dart';

const _kAccent = Color(0xFFB7F34A);

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _agreed = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _signUp() {
    final bloc = context.read<AuthBloc>();
    if (bloc.state.isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      _showError(context, 'Please accept the terms and conditions');
      return;
    }
    FocusScope.of(context).unfocus();
    bloc.add(AuthEvent.registerRequested(
      name: _name.text.trim(),
      email: _email.text.trim(),
      password: _password.text,
    ));
  }

  void _google() {
    final bloc = context.read<AuthBloc>();
    if (bloc.state.isLoading) return;
    FocusScope.of(context).unfocus();
    bloc.add(const AuthEvent.googleSignInRequested());
  }

  void _onState(BuildContext context, AuthState state) {
    // Only the visible screen reacts.
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state.status == AuthStatus.success) {
      // main.dart already swapped home; remove this pushed route.
      Navigator.of(context).popUntil((r) => r.isFirst);
    } else if (state.message != null) {
      _showError(context, state.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) =>
          c.status == AuthStatus.success || c.status == AuthStatus.failure,
      listener: _onState,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Form(
              key: _formKey,
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (p, c) => p.status != c.status || p.method != c.method,
                builder: (context, state) {
                  final busy = state.isLoading;
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: busy ? null : () => Navigator.pop(context),
                        ),
                      ),
                      Image.asset('assets/images/futhub_white.png',
                          height: 120, width: 220, color: Colors.white),
                      Text('Get Started',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text('Enter your details below',
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.white)),
                      const SizedBox(height: 30),
                      IgnorePointer(
                        ignoring: busy,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 150),
                          opacity: busy ? 0.6 : 1,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _name,
                                hint: 'Full name',
                                icon: Icons.person_outline,
                                textInputAction: TextInputAction.next,
                                validator: (v) =>
                                    (v == null || v.trim().length < 2)
                                        ? 'Name is required'
                                        : null,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: _email,
                                hint: 'Email address',
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (v) {
                                  final s = v?.trim() ?? '';
                                  if (s.isEmpty) return 'Email is required';
                                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                      .hasMatch(s)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: _password,
                                hint: 'Password',
                                icon: Icons.lock_outline,
                                isPassword: true,
                                textInputAction: TextInputAction.next,
                                validator: (v) => (v == null || v.length < 8)
                                    ? 'At least 8 characters'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: _confirm,
                                hint: 'Confirm password',
                                icon: Icons.lock_outline,
                                isPassword: true,
                                textInputAction: TextInputAction.done,
                                validator: (v) => v != _password.text
                                    ? 'Passwords do not match'
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              TermsCheckbox(
                                value: _agreed,
                                onChanged: (v) => setState(() => _agreed = v),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SignUpButton(
                        onPressed: _signUp,
                        isLoading: state.isEmailLoading,
                      ),
                      const SizedBox(height: 26),
                      const _OrDivider(text: 'Or sign up with'),
                      const SizedBox(height: 22),
                      _GoogleButton(
                        loading: state.isGoogleLoading,
                        onPressed: busy ? null : _google,
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.white70)),
                          GestureDetector(
                            onTap: busy ? null : () => Navigator.pop(context),
                            child: Text('Sign In',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _kAccent)),
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
    );
  }
}

void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
    ));
}

class _OrDivider extends StatelessWidget {
  final String text;
  const _OrDivider({required this.text});

  @override
  Widget build(BuildContext context) {
    final line = Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.3)));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          line,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(text,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: loading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black87),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('G',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4285F4))),
                    const SizedBox(width: 10),
                    Text('Google',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
        ),
      ),
    );
  }
}