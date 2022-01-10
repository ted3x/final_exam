import 'package:final_exam/extensions/date_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class EditTextWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String validationText;

  const EditTextWidget(this.hint, this.controller, this.validationText);

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
      textAlign: TextAlign.start,
      style: const TextStyle(color: Color(textColor), fontSize: 18),
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(0),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
              fontSize: 18, color: const Color(0x59707070))),
    );
  }
}
