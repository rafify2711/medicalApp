import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/button.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';

import '../../core/utils/app_style.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              Image(
                image: AssetImage('lib/assets/icon/VectorColored.png'),
                height: 150,
                width: 150,
              ),
              Center(
                child: Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).app,
                      style: AppStyle.titlesTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).name,
                      style: AppStyle.titlesTextStyle.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    AppLocalizations.of(context).welcomeDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: AppColors.black),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Button(text: AppLocalizations.of(context).login, onClick: (){
                Navigator.pushNamed(context, RouteNames.login);
              },
              height:45 ,
              width: 200,
                  color: AppColors.primary),
              SizedBox(height: 5,),
              Button(text: AppLocalizations.of(context).signUp, onClick: (){
                Navigator.pushNamed(context, RouteNames.signUp);
              },
                  height:45 ,
                  width: 200,
                  color: AppColors.fill),

              SizedBox(height: 40,)

            ],
          ),
        ),
      ),
    );
  }
}
