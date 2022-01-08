import 'package:flutter/material.dart';

class RoundedRectangleButtonWidget extends StatelessWidget {
  final int backgroundColor;
  final Text? text;
  final Function()? onClick;

  const RoundedRectangleButtonWidget(
      this.backgroundColor, this.text, this.onClick,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 189,
      height: 37,
      decoration: BoxDecoration(
        color: Color(backgroundColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
          onPressed: () {
            if (onClick != null) onClick!();
          },
          child: text),
    );
  }
}
