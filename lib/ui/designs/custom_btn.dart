import 'package:flutter/material.dart';
import 'package:quiz_app/constants/colors.dart';

class CustomBtn extends StatelessWidget {
  final String btnText;
  final double txtSize;
  final VoidCallback onPressedFn;
  final Size btnSize;
  final Color btnClr;
  const CustomBtn({
    Key? key,
    required this.btnText,
    required this.txtSize,
    required this.onPressedFn,
    required this.btnSize,
    required this.btnClr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressedFn,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(btnClr),
        fixedSize: MaterialStateProperty.all(btnSize),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: txtSize,
          ),
        ),
      ),
      child: Text(
        btnText,
        style: TextStyle(
          color: ConstantColors.kPrimaryColor,
        ),
      ),
    );
  }
}
