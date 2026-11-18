import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({
    super.key,
    required this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.autofillHints = const [AutofillHints.password],
  });

  final TextEditingController controller;

  /// Optional. Pass one from the screen to control focus. If null, the widget
  /// creates and disposes its own.
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  FocusNode? _ownFocusNode;
  bool _obscure = true;

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
        obscureText: _obscure,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onSubmitted,
        autofillHints: widget.autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        enableSuggestions: false,
        cursorColor: const Color(0xFFB7F34A),
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        // Only checks it's filled in. The server decides if it's correct.
        validator: (v) =>
            (v == null || v.isEmpty) ? 'Password is required' : null,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
          suffixIcon: IconButton(
            tooltip: _obscure ? 'Show password' : 'Hide password',
            icon: Icon(
              _obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.white70,
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
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