import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/organizer_register/organizer_register_bloc.dart';
import 'package:football_app/bloc/organizer_register/organizer_register_event.dart';
import 'package:football_app/bloc/organizer_register/organizer_register_state.dart';
import 'package:football_app/repository/organizer/organizer_repository.dart';
import 'package:google_fonts/google_fonts.dart';

/// Provides the bloc. Navigate to this one.
class BecomeOrganizerScreen extends StatelessWidget {
  const BecomeOrganizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => OrganizerRegisterBloc(ctx.read<OrganizerRepository>()),
      child: const _BecomeOrganizerView(),
    );
  }
}

class _BecomeOrganizerView extends StatefulWidget {
  const _BecomeOrganizerView();

  @override
  State<_BecomeOrganizerView> createState() => _BecomeOrganizerViewState();
}

class _BecomeOrganizerViewState extends State<_BecomeOrganizerView> {
  final _formKey = GlobalKey<FormState>();

  // Organization
  final _orgNameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _logoUrlController = TextEditingController();

  // User (admin)
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String _slugPreview = '';

  @override
  void initState() {
    super.initState();
    _orgNameController.addListener(() {
      final slug = _slugify(_orgNameController.text);
      if (slug != _slugPreview) setState(() => _slugPreview = slug);
    });
  }

  @override
  void dispose() {
    _orgNameController.dispose();
    _contactEmailController.dispose();
    _logoUrlController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String _slugify(String s) => s
      .toLowerCase()
      .trim()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    Widget? suffix,
    String? helper,
  }) {
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: c, width: w),
    );
    return InputDecoration(
      labelText: label,
      helperText: helper,
      helperStyle: GoogleFonts.poppins(fontSize: 11, color: Colors.white38),
      labelStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFF1C1C1E),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: border(Colors.white12),
      enabledBorder: border(Colors.white12),
      focusedBorder: border(Colors.green, 1.5),
      errorBorder: border(Colors.redAccent),
      focusedErrorBorder: border(Colors.redAccent, 1.5),
      errorStyle: GoogleFonts.poppins(fontSize: 11),
    );
  }

  Widget _sectionTitle(String text, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.white54),
            ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
      ),
    );
  }

  Future<void> _showSuccessDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              'Organizer Created',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        content: Text(
          'Your organization is ready. You can now log in with your email and password.',
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'OK',
              style: GoogleFonts.poppins(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final bloc = context.read<OrganizerRegisterBloc>();
    if (!bloc.state.agreed) {
      _showError('Please accept the terms to continue');
      return;
    }

    bloc.add(
      OrganizerRegisterEvent.submitted(
        organizationName: _orgNameController.text.trim(),
        contactEmail: _contactEmailController.text.trim(),
        logoUrl: _logoUrlController.text.trim(),
        userName: _userNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputStyle = GoogleFonts.poppins(color: Colors.white, fontSize: 14);

    return BlocConsumer<OrganizerRegisterBloc, OrganizerRegisterState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) async {
        if (state.status == RegisterStatus.failure) {
          _showError(state.errorMessage ?? 'Something went wrong');
        } else if (state.status == RegisterStatus.success) {
          await _showSuccessDialog();
          if (!mounted) return;
          Navigator.pop(this.context);
        }
      },
      builder: (context, state) {
        final isSubmitting = state.status == RegisterStatus.loading;
        final bloc = context.read<OrganizerRegisterBloc>();

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Become an Organizer',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.withValues(alpha: 0.35),
                            const Color(0xFF1C1C1E),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.sports_soccer,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Host your own tournaments',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Create your organization to manage tournaments, teams, players and matches.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ---------- Organization ----------
                    _sectionTitle(
                      'Organization',
                      subtitle: 'This is what players will see',
                    ),
                    TextFormField(
                      controller: _orgNameController,
                      style: inputStyle,
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration(
                        'Organization Name',
                        Icons.business_outlined,
                        helper: _slugPreview.isEmpty
                            ? 'Your unique ID will be generated from the name'
                            : 'Your ID: $_slugPreview',
                      ),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) {
                          return 'Please enter organization name';
                        }
                        if (_slugify(value).isEmpty) {
                          return 'Use letters or numbers in the name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _contactEmailController,
                      style: inputStyle,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        'Contact Email',
                        Icons.alternate_email,
                        helper: 'Shown publicly for team enquiries',
                      ),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) {
                          return 'Please enter a contact email';
                        }
                        if (!_emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _logoUrlController,
                      style: inputStyle,
                      keyboardType: TextInputType.url,
                      decoration: _inputDecoration(
                        'Logo URL (optional)',
                        Icons.image_outlined,
                      ),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return null;
                        final uri = Uri.tryParse(value);
                        if (uri == null ||
                            !uri.hasAuthority ||
                            !(uri.scheme == 'http' || uri.scheme == 'https')) {
                          return 'Enter a valid http(s) link';
                        }
                        return null;
                      },
                    ),

                    // ---------- Admin account ----------
                    _sectionTitle(
                      'Admin Account',
                      subtitle: 'You will log in with these details',
                    ),
                    TextFormField(
                      controller: _userNameController,
                      style: inputStyle,
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration(
                        'Your Full Name',
                        Icons.person_outline,
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Please enter your name'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _emailController,
                      style: inputStyle,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        'Login Email',
                        Icons.email_outlined,
                      ),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'Please enter your email';
                        if (!_emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: state.hidePassword,
                      style: inputStyle,
                      decoration: _inputDecoration(
                        'Password',
                        Icons.lock_outline,
                        suffix: IconButton(
                          icon: Icon(
                            state.hidePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.white54,
                            size: 20,
                          ),
                          onPressed: () => bloc.add(
                            const OrganizerRegisterEvent.passwordVisibilityToggled(),
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (v.length < 6) return 'At least 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _confirmController,
                      obscureText: state.hidePassword,
                      style: inputStyle,
                      decoration: _inputDecoration(
                        'Confirm Password',
                        Icons.lock_reset,
                      ),
                      validator: (v) => v != _passwordController.text
                          ? 'Passwords do not match'
                          : null,
                    ),

                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: state.agreed,
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          side: const BorderSide(color: Colors.white54),
                          onChanged: (v) => bloc.add(
                            OrganizerRegisterEvent.termsChanged(v ?? false),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              'I agree to the organizer terms and conditions.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          disabledBackgroundColor: Colors.green.withValues(
                            alpha: 0.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: isSubmitting
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Create Organization',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
