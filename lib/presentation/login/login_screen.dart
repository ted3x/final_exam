import 'package:final_exam/main.dart';
import 'package:final_exam/widgets/rounded_rectangle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/logo.png', width: 160, height: 132),
            const SizedBox(height: 80),
            const RoundedRectangleButtonWidget(lightGreen, null, null),
            const SizedBox(height: 30),
            RoundedRectangleButtonWidget(
                lightGreen,
                Text('LOGIN',
                    style: GoogleFonts.roboto(
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 16))), () {
              Navigator.pushNamed(context, '/dashboard');
            })
          ],
        ),
      ),
    );
  }
}
