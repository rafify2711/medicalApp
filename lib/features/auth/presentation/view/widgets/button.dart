import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style.dart';


class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onClick,
  });

  final String text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 190,
        child: ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: AppStyle.gradient,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                text,
                style: AppStyle.bodyWhiteTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
