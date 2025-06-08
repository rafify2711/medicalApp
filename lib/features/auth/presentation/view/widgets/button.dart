import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color? color;
  final double? width;
  final double? height;

  const Button({
    super.key,
    required this.text,
    required this.onClick,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWhite = color == AppColors.fill;

    return Center(
      child: SizedBox(
        height: height ?? 50,
        width: width ?? 190,
        child: ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            elevation: WidgetStateProperty.all(0),
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: isWhite ? AppColors.fill : null,
              gradient: isWhite ? null : AppStyle.gradient,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: isWhite
                    ? AppStyle.bodyCyanTextStyle.copyWith(
                        fontSize: 16,
                        height: 1.2,
                      )
                    : AppStyle.bodyWhiteTextStyle.copyWith(
                        fontSize: 16,
                        height: 1.2,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
