import 'package:al_motafawiq/feature/feature_admin/dashboard_admin/presentation/dashboard_admin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../core/theme/app_text_style.dart';
import '../../core/widgets/animate_gradient.dart';
import '../auth/preasntation/register_screen.dart';
import '../landing/presentation/landing_screen.dart';
import '../welcome/presentation/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  Future<bool> checkUserExists() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;
      await user.reload(); // يحدث بيانات المستخدم من الخادم
      return FirebaseAuth.instance.currentUser != null;
    } catch (e) {
      return false;
    }
  }
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () async { // قللت الوقت من 5 ثواني لـ 3
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          await user.reload(); // يحدث بيانات المستخدم من الخادم
          final currentUser = FirebaseAuth.instance.currentUser;

          if (currentUser != null) {
            // جلب بيانات الدور من Firestore
            final doc = await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .get();

            final role = doc['role'] ?? 'user';
            print('Role: $role'); // للتأكد في اللوج

            if (role == 'admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashboardAdminScreen()), // صفحة الأدمين
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LandingScreen()), // صفحة المستخدم العادي
              );
            }
            return;
          }
        } catch (e) {
          print('Error checking user: $e');
        }
      }

      // المستخدم جديد أو لم يسجل دخول
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WelcomeScreen()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/images/Online Learning.json"),
                    SizedBox(height: 15.h),
                    Text("AlMotafawiq", style: AppTextStyle.Bold30Whit),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
