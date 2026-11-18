import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/bloc/auth/auth_event.dart';
import 'package:football_app/bloc/auth/auth_state.dart';
import 'package:football_app/config/routes/route_names.dart';
// Adjust these three paths to where your widgets live.
import 'package:football_app/view/signup/widgets/custom_textfield_widget.dart';
import 'package:football_app/view/signup/widgets/signup_button_widget.dart';
import 'package:football_app/view/signup/widgets/terms_checkbox_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

const _kAccent = Color(0xFFB7F34A);

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _confirmKey = GlobalKey<FormFieldState<String>>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _agreed = false;
  bool _termsError = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _signUp() {
    final bloc = context.read<AuthBloc>();
    if (bloc.state.isLoading) return;

    final formOk = _formKey.currentState!.validate();
    setState(() => _termsError = !_agreed);
    if (!formOk || !_agreed) return;

    FocusScope.of(context).unfocus();
    bloc.add(
      AuthEvent.registerRequested(
        name: _name.text.trim(),
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

  /// Goes back to Sign In. Passes the email back so Sign In can prefill it.
  void _goBack([String? email]) {
    if (context.canPop()) {
      context.pop(email);
    } else {
      context.go(RouteNames.signIn);
    }
  }

  void _onState(BuildContext context, AuthState state) {
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state.status == AuthStatus.registered) {
      // Lets the OS / password manager offer to save the new credentials.
      TextInput.finishAutofillContext();
      _showSuccess(
        context,
        state.message ?? 'Account created. Please sign in.',
      );
      _goBack(_email.text.trim());
      return;
    }

    if (state.status == AuthStatus.failure && state.message != null) {
      _showError(context, state.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) =>
          c.status == AuthStatus.registered ||
          c.status == AuthStatus.success ||
          c.status == AuthStatus.failure,
      listener: _onState,
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (p, c) => p.status != c.status || p.method != c.method,
        builder: (context, state) {
          final busy = state.isLoading;
          return PopScope(
            // Blocks the system back gesture / button while a request runs.
            canPop: !busy,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AutofillGroup(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: busy ? null : () => _goBack(),
                            ),
                          ),
                          Image.asset(
                            'assets/images/futhub_white.png',
                            height: 120,
                            width: 220,
                            color: Colors.white,
                          ),
                          Text(
                            'Get Started',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Enter your details below',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
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
                                    focusNode: _nameFocus,
                                    hint: 'Full name',
                                    icon: Icons.person_outline,
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.name],
                                    onSubmitted: (_) =>
                                        _emailFocus.requestFocus(),
                                    validator: (v) =>
                                        (v == null || v.trim().length < 2)
                                            ? 'Name is required'
                                            : null,
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    controller: _email,
                                    focusNode: _emailFocus,
                                    hint: 'Email address',
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.email],
                                    onSubmitted: (_) =>
                                        _passwordFocus.requestFocus(),
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
                                    focusNode: _passwordFocus,
                                    hint: 'Password',
                                    icon: Icons.lock_outline,
                                    isPassword: true,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [
                                      AutofillHints.newPassword,
                                    ],
                                    onSubmitted: (_) =>
                                        _confirmFocus.requestFocus(),
                                    // Re-check "confirm" as the password
                                    // changes, but only once it has text.
                                    onChanged: (_) {
                                      if (_confirm.text.isNotEmpty) {
                                        _confirmKey.currentState?.validate();
                                      }
                                    },
                                    // Keep this in sync with your backend rule.
                                    validator: (v) {
                                      final s = v ?? '';
                                      if (s.length < 8) {
                                        return 'At least 8 characters';
                                      }
                                      if (!RegExp(r'[A-Za-z]').hasMatch(s) ||
                                          !RegExp(r'\d').hasMatch(s)) {
                                        return 'Use letters and numbers';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    controller: _confirm,
                                    focusNode: _confirmFocus,
                                    fieldKey: _confirmKey,
                                    hint: 'Confirm password',
                                    icon: Icons.lock_outline,
                                    isPassword: true,
                                    textInputAction: TextInputAction.done,
                                    autofillHints: const [
                                      AutofillHints.newPassword,
                                    ],
                                    onSubmitted: (_) => _signUp(),
                                    validator: (v) => v != _password.text
                                        ? 'Passwords do not match'
                                        : null,
                                  ),
                                  const SizedBox(height: 8),
                                  TermsCheckbox(
                                    value: _agreed,
                                    errorText: _termsError
                                        ? 'Please accept the terms to continue'
                                        : null,
                                    onChanged: (v) => setState(() {
                                      _agreed = v;
                                      if (v) _termsError = false;
                                    }),
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
                              Text(
                                'Already have an account? ',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                              GestureDetector(
                                onTap: busy ? null : () => _goBack(),
                                child: Text(
                                  'Sign In',
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
}

void _showSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
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