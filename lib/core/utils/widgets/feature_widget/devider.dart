import 'package:flutter/material.dart';

import '../../app_colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  AppColors.fill,
      width: MediaQuery.of(context).size.width*0.85,
      height: 1,
    );
  }
}
