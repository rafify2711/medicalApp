import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/button.dart';

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.35),
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
                      'App',
                      style: AppStyle.titlesTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Name',
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing '
                        'elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: AppColors.black),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Button(text: 'Log In', onClick: (){
                Navigator.pushNamed(context, RouteNames.login);
              },
              height:45 ,
              width: 200,
                  color: AppColors.primary),
              SizedBox(height: 5,),
              Button(text: 'Sign Up', onClick: (){
                Navigator.pushNamed(context, RouteNames.signUp);
              },
                  height:45 ,
                  width: 200,
                  color: AppColors.fill),

            ],
          ),
        ),
      ),
    );
  }
}
