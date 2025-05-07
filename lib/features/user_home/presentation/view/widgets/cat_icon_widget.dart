import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class CatIconWidget extends StatelessWidget {
  const CatIconWidget({super.key, required this.label, required this.asset, required this.route});
  final String label;
  final String asset;
  final String route;

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: ()=>Navigator.pushNamed(context, route),
        child: Column(
          children: [
            ImageIcon(
              AssetImage(asset),
              size: 25,
              color: AppColors.primary1,
            ),
            Text(
              label,
              style: TextStyle(
                color: AppColors.primary1,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );  }
}
