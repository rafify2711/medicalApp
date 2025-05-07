import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';

class TermsOfUseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Gradient AppBar
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 48, bottom: 24),
            decoration: BoxDecoration(
              gradient: AppStyle.gradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Terms of Use',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to our app! By using this application, you agree to the following terms and conditions.',
                      style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 18),
                    _buildBullet('You must be at least 18 years old to use this app.'),
                    _buildBullet('Do not use the app for any illegal or unauthorized purpose.'),
                    _buildBullet('We reserve the right to terminate your account if you violate these terms.'),
                    _buildBullet('The app is provided as-is, without warranty of any kind.'),
                    _buildBullet('Your data may be used to improve our services.'),
                    _buildBullet('These terms may change at any time, and continued use means you accept the new terms.'),
                    SizedBox(height: 18),
                    Text(
                      'Thank you for using our app!',
                      style: AppStyle.bodyBlackTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary1,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 18, color: AppColors.primary1)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}