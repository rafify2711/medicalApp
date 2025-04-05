import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style.dart';


class MyAppPar extends StatelessWidget implements PreferredSizeWidget{
  MyAppPar({super.key,required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      flexibleSpace: Container(
        decoration:  BoxDecoration(
          gradient: AppStyle.gradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                    Center(
                      child: Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),

                                        ),
                    ),




          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
