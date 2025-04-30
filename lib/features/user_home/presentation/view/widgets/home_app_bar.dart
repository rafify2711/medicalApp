import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/models/user_model/user_model.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  UserModel user;
   HomeAppBar({super.key, required this.user});


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 40,right: 20,left: 20),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(backgroundColor: AppColors.fill,
                  child: ImageIcon(AssetImage('lib/assets/icon/notification.png'),size: 15,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(backgroundColor: AppColors.fill,
                  child: ImageIcon(AssetImage('lib/assets/icon/sittings.png'),size: 15,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(backgroundColor: AppColors.fill,
                  child: ImageIcon(AssetImage('lib/assets/icon/search.png'),size: 15,),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text('Hi, WelcomeBack',style: TextStyle(color: AppColors.primary1,fontSize: 13,fontWeight: FontWeight.w400),),
                  Text('${user.username}',style: TextStyle(color: AppColors.black,fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                ],


              ),
              const SizedBox(width: 5,),
              CircleAvatar(
                backgroundColor: AppColors.primary1,
              )

            ],


      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
