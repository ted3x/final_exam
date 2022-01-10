import 'package:flutter/material.dart';

class RoundButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color onPrimaryBackgroundColor;
  final IconData? icon;
  final Color? iconColor;
  final Function()? onClick;

  const RoundButtonWidget(
      this.backgroundColor, this.onPrimaryBackgroundColor, this.icon, this.iconColor, this.onClick,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Icon(icon, color: iconColor),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        primary: backgroundColor,
        onPrimary: onPrimaryBackgroundColor,
        minimumSize: const Size(40, 40)
      ),
    );
  }
}
