import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseItemWidget extends StatelessWidget {
  final String title;
  final String amount;
  final DateTime date;

  const ExpenseItemWidget(this.title, this.amount, this.date);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
    return Card(
        elevation: 6,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.black.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Container(
            padding:
                const EdgeInsets.only(left: 27, right: 24, top: 15, bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 20, color: Color(0xFF707070)))),
                    Text(amount,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 18, color: Color(0xFF707070))))
                  ],
                ),
                const SizedBox(width: 9),
                Text(formattedDate,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 12, color: Color(0x73707070)))),
              ],
            )));
  }
}
