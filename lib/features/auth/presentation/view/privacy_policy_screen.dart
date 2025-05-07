import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';

class PrivacyPolicyScreen extends StatelessWidget {
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
                      'Privacy Policy',
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
                      'We value your privacy and are committed to protecting your personal information.',
                      style: AppStyle.bodyBlackTextStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 18),
                    _buildBullet('We collect only the data necessary to provide our services.'),
                    _buildBullet('Your data will not be shared with third parties without your consent.'),
                    _buildBullet('We use industry-standard security measures to protect your information.'),
                    _buildBullet('You can request deletion of your data at any time.'),
                    _buildBullet('This policy may be updated, and continued use of the app means you accept the changes.'),
                    SizedBox(height: 18),
                    Text(
                      'If you have any questions, please contact our support team.',
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