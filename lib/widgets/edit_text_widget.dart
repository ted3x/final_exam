import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class EditTextWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String validationText;
  final TextAlign textAlign;
  final Color underlineColor;

  const EditTextWidget(this.hint, this.controller, this.validationText, this.textAlign, this.underlineColor);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationText;
        }
        return null;
      },
      textAlignVertical: TextAlignVertical.center,
      textAlign: textAlign,
      style: const TextStyle(color: Color(textColor), fontSize: 18),
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: underlineColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: underlineColor),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
              fontSize: 18, color: const Color(0x59707070))),
    );
  }
}
