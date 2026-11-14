import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/view/common/auth_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _org = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _agreed = false;
  bool _googlePressed = false;

  @override
  void dispose() {
    _org.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      showError(context, 'Please accept the terms and conditions');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _googlePressed = false);
    context.read<AuthBloc>().add(AuthEvent.registerRequested(
          organizationName: _org.text,
          name: _name.text,
          email: _email.text,
          password: _password.text,
        ));
  }

  void _google() {
    setState(() => _googlePressed = true);
    context.read<AuthBloc>().add(const AuthEvent.googleSignInRequested());
  }

  Future<void> _onState(BuildContext context, AuthState state) async {
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state.status == AuthStatus.success) {
      // main.dart already swapped home -> BottomNavigationScreen; remove this pushed route.
      Navigator.of(context).popUntil((r) => r.isFirst);
    } else if (state.organizationRequired) {
      final org = await askOrganizationName(context, userName: state.googleName);
      if (!context.mounted) return;
      if (org != null) {
        context.read<AuthBloc>().add(AuthEvent.googleOrganizationSubmitted(organizationName: org));
      }
    } else if (state.message != null) {
      showError(context, state.message!);
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
                builder: (context, state) {
                  final loading = state.status == AuthStatus.loading;
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Image.asset('assets/images/futbookok.png',
                          height: 120, width: 220, color: Colors.white),
                      Text('Get Started',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text('Enter your details below',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
                      const SizedBox(height: 20),
                      AuthTextField(
                        controller: _org,
                        hint: 'Organization name',
                        icon: Icons.business_outlined,
                        validator: (v) => (v == null || v.trim().length < 2)
                            ? 'Organization name is required'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        controller: _name,
                        hint: 'Full name',
                        icon: Icons.person_outline,
                        validator: (v) => (v == null || v.trim().length < 2)
                            ? 'Name is required'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        controller: _email,
                        hint: 'Email address',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          final s = v?.trim() ?? '';
                          if (s.isEmpty) return 'Email is required';
                          if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        controller: _password,
                        hint: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                        validator: (v) =>
                            (v == null || v.length < 8) ? 'At least 8 characters' : null,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        controller: _confirm,
                        hint: 'Confirm password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        validator: (v) =>
                            v != _password.text ? 'Passwords do not match' : null,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _agreed,
                              activeColor: kAccent,
                              checkColor: Colors.black,
                              onChanged: (v) => setState(() => _agreed = v ?? false),
                            ),
                            Expanded(
                              child: Text('I agree to the Terms & Conditions',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.white70)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Sign Up',
                        loading: loading && !_googlePressed,
                        onPressed: loading ? null : _signUp,
                      ),
                      const SizedBox(height: 26),
                      const OrDivider(text: 'Or sign up with'),
                      const SizedBox(height: 22),
                      GoogleButton(
                        loading: loading && _googlePressed,
                        onPressed: loading ? null : _google,
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.white70)),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text('Sign In',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: kAccent)),
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