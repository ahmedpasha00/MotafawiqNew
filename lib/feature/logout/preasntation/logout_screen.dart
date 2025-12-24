import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/welcome/presentation/welcome_screen.dart'; // صفحة Welcome

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          icon: Icon(Icons.logout, color: Colors.white),
          label: Text(
            "تسجيل الخروج",
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
          onPressed: () {
            // عرض dialog لتأكيد الخروج
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text("تأكيد"),
                content: Text("هل أنت متأكد من تسجيل الخروج؟"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(); // إغلاق الـ dialog
                    },
                    child: Text("لا"),
                  ),
                  TextButton(
                    onPressed: () async {
                      // تسجيل الخروج
                      await FirebaseAuth.instance.signOut();
                      // الرجوع لصفحة Welcome وحذف كل الصفحات السابقة
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => WelcomeScreen()),
                            (route) => false,
                      );
                    },
                    child: Text("نعم"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
