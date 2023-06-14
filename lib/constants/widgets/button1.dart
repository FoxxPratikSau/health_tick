import 'package:flutter/material.dart';
import 'package:health_tick/Theme/colors.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const SmallButton({
    super.key,
    required this.onTap,
    required this.label,
    this.backgroundColor = greenColor,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(19),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromARGB(255, 3, 194, 133), offset: Offset(0, 5))
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.1),
          ),
        ),
      ),
    );
  }
}
