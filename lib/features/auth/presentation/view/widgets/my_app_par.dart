import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style.dart';

class MyAppPar extends StatelessWidget implements PreferredSizeWidget {
  MyAppPar({super.key, required this.title,this.action});
  final String title;
  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
  automaticallyImplyLeading: false,
      actions: action,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: AppStyle.gradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
