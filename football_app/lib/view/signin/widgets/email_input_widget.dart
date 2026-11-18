import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailInputWidget extends StatefulWidget {
  const EmailInputWidget({
    super.key,
    required this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.autofillHints = const [AutofillHints.username, AutofillHints.email],
  });

  final TextEditingController controller;

  /// Optional. Pass one from the screen to control focus. If null, the widget
  /// creates and disposes its own.
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;

  @override
  State<EmailInputWidget> createState() => _EmailInputWidgetState();
}

class _EmailInputWidgetState extends State<EmailInputWidget> {
  FocusNode? _ownFocusNode;

  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownFocusNode ??= FocusNode());

  @override
  void dispose() {
    _ownFocusNode?.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.emailAddress,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onSubmitted,
        autofillHints: widget.autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        cursorColor: const Color(0xFFB7F34A),
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        validator: (v) {
          final value = v?.trim() ?? '';
          if (value.isEmpty) return 'Email is required';
          if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
            return 'Enter a valid email';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Email address',
          hintStyle: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF191919),
          border: _border(const Color(0xFF303030)),
          enabledBorder: _border(const Color(0xFF303030)),
          focusedBorder: _border(const Color(0xFFB7F34A)),
          errorBorder: _border(Colors.redAccent),
          focusedErrorBorder: _border(Colors.redAccent),
          errorStyle: GoogleFonts.poppins(
            color: Colors.redAccent,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}