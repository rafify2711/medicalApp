import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppStyle {
  static const TextStyle appBarStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.white);
  static const TextStyle titlesTextStyle = TextStyle(
      fontSize: 27, fontWeight: FontWeight.bold, color: AppColors.primary);

  static const TextStyle bodyCyanTextStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary);

  static const TextStyle bodyWhiteTextStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.white);

  static const TextStyle bodyBlackTextStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black);

  static const TextStyle appBarDarkStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.black);

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
  textStyle: const TextStyle(fontSize: 16));

  static const  LinearGradient gradient= LinearGradient(

        colors: [
          Color(0xFF30948F), // Color at 0%
          Color(0xFF00BBD3), // Color at 100%
        ],
        stops: [0.0, 1.0], // Positions of the gradient stops
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static const TextStyle unSelectedCalendarDayStyle = TextStyle(
      color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 15);

  static  TextStyle selectedCalendarDayStyle =
  unSelectedCalendarDayStyle.copyWith(color: AppColors.primary);
}