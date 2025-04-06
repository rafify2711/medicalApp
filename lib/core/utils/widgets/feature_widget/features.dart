import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../app_style.dart';

class FeatureCard extends StatelessWidget {
  final IconData? icon;
  final String? image;  // الصورة
  final String label;
  final String routeName;

  const FeatureCard({
    Key? key,
    this.icon,
    required this.label,
    required this.routeName,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: AppStyle.gradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // If image is provided, use Image.asset
              if (image != null)
                Image.asset(color: AppColors.white,
                  image!,
                  width: 30,
                  height: 30,
                )
              else if (icon != null)
                Icon(icon, size: 25, color: AppColors.white),
              const SizedBox(height: 10),
              Text(
                label,
                style: AppStyle.bodyWhiteTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class FeaturesGrid extends StatelessWidget {
  final List<Map<String, dynamic>> features;

  const FeaturesGrid({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: AppStyle.gradient,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(feature['icon'], size: 40, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  feature['text'],
                  style: const TextStyle( color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
