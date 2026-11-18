import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final GlobalKey<FormFieldState<String>>? fieldKey;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.controller,
    this.validator,
    this.onSubmitted,
    this.onChanged,
    this.autofillHints,
    this.fieldKey,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        key: widget.fieldKey,
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        validator: widget.validator,
        onFieldSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        autofillHints: widget.autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPassword && _obscure,
        autocorrect: false,
        enableSuggestions: !widget.isPassword,
        cursorColor: const Color(0xFFB7F34A),
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
          errorStyle:
              GoogleFonts.poppins(fontSize: 11, color: Colors.redAccent),
          prefixIcon: Icon(widget.icon, color: Colors.white70),
          suffixIcon: widget.isPassword
              ? IconButton(
                  tooltip: _obscure ? 'Show password' : 'Hide password',
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white70,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF191919),
          border: _border(const Color(0xFF303030)),
          enabledBorder: _border(const Color(0xFF303030)),
          focusedBorder: _border(const Color(0xFFB7F34A)),
          errorBorder: _border(Colors.redAccent),
          focusedErrorBorder: _border(Colors.redAccent),
        ),
      ),
    );
  }
}