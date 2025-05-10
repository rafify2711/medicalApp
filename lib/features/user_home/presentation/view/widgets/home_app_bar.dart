import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/models/user_model/user_model.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  UserModel user;
  HomeAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: CircleAvatar(
              backgroundColor: AppColors.fill,
              child: ImageIcon(AssetImage('lib/assets/icon/notification.png'), size: 15),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.settings);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: CircleAvatar(
                backgroundColor: AppColors.fill,
                child: ImageIcon(AssetImage('lib/assets/icon/sittings.png'), size: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, RouteNames.globalSearch),
              child: CircleAvatar(
                backgroundColor: AppColors.fill,
                child: ImageIcon(AssetImage('lib/assets/icon/search.png'), size: 15),
              ),
            ),
          ),
          Spacer(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).welcomeBack,
                    style: TextStyle(
                      color: AppColors.primary1,
                      fontSize: 13,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    user.username??'user',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
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
