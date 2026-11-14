import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/view/common/auth_widgets.dart';
import 'package:football_app/view/forget_password/forget_password_screen.dart';
import 'package:football_app/view/signup/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _googlePressed = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _googlePressed = false);
    context.read<AuthBloc>().add(AuthEvent.loginRequested(email: _email.text, password: _password.text));
  }

  void _google() {
    setState(() => _googlePressed = true);
    context.read<AuthBloc>().add(const AuthEvent.googleSignInRequested());
  }

  Future<void> _onState(BuildContext context, AuthState state) async {
    // SignupScreen may be pushed on top of this screen - only the visible one reacts.
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state.organizationRequired) {
      final org = await askOrganizationName(context, userName: state.googleName);
      if (!context.mounted) return;
      if (org != null) {
        context.read<AuthBloc>().add(AuthEvent.googleOrganizationSubmitted(organizationName: org));
      }
    } else if (state.message != null) {
      showError(context, state.message!);
    }
    // success needs no navigation: main.dart swaps the home screen.
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
              child: Image.asset('assets/images/login_image.jpg', fit: BoxFit.cover),
            ),
            Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.45))),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final loading = state.status == AuthStatus.loading;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Hello!',
                                    style: GoogleFonts.poppins(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text('Sign in to your account',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                                const SizedBox(height: 50),
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
                                const SizedBox(height: 15),
                                AuthTextField(
                                  controller: _password,
                                  hint: 'Password',
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                  textInputAction: TextInputAction.done,
                                  validator: (v) =>
                                      (v == null || v.isEmpty) ? 'Password is required' : null,
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ForgetPasswordScreen()),
                                      ),
                                      child: Text('Forgot Password?',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                PrimaryButton(
                                  label: 'Login',
                                  loading: loading && !_googlePressed,
                                  onPressed: loading ? null : _login,
                                ),
                                const SizedBox(height: 30),
                                const OrDivider(text: 'Or sign in with'),
                                const SizedBox(height: 25),
                                GoogleButton(
                                  loading: loading && _googlePressed,
                                  onPressed: loading ? null : _google,
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account? ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12, color: Colors.white70)),
                                    InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const SignupScreen()),
                                      ),
                                      child: Text('Sign Up',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}