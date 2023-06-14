import 'package:flutter/material.dart';
import 'package:health_tick/Theme/colors.dart';

class TransparentButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const TransparentButton({
    super.key,
    required this.onTap,
    required this.label,
    this.backgroundColor = Colors.transparent,
    this.textColor = greenColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: greenColor,
            width: 2,
          ),
          // boxShadow: const <BoxShadow>[
          //   BoxShadow(
          //       color: Color.fromARGB(255, 3, 194, 133), offset: Offset(0, 5))
          // ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
