import 'package:al_motafawiq/core/theme/app_text_style.dart';
import 'package:al_motafawiq/core/widgets/cousstom_botton.dart';
import 'package:al_motafawiq/core/widgets/coustom_language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/animate_gradient.dart';
import '../../welcome/presentation/welcome_screen.dart';

class LogoutAdminScreen extends StatelessWidget {
  const LogoutAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // زر تسجيل الخروج
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      elevation: 5,
                    ),
                    icon: Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      "logout".tr(), // ✅ جاهز للترجمة
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Confirm".tr()), // ✅ جاهز للترجمة
                          content: Text("Are you sure you want to logout?".tr()), // ✅ جاهز للترجمة
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text("No".tr()), // ✅ جاهز للترجمة
                            ),
                            TextButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => WelcomeScreen()),
                                      (route) => false,
                                );
                              },
                              child: Text("Yes".tr()), // ✅ جاهز للترجمة
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    "Change Language".tr(), // ✅ جاهز للترجمة
                    style: AppTextStyle.Bold25Whit,
                  ),
                  CoustomLanguage(),
                  SizedBox(height: 200.h),
                  CousstomBotton(titell: 'الرجوع للصفحة الرئيسيه'.tr(),
                  onTap: (){
                    Navigator.pop(context);
                  },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
