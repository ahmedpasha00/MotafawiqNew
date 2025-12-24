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
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () async {
      final user = FirebaseAuth.instance.currentUser;

      bool exists = false;
      if(user != null){
        try {
          await user.reload(); // يحدث بيانات المستخدم من الخادم
          exists = FirebaseAuth.instance.currentUser != null;
        } catch (e) {
          exists = false;
        }
      }

       if(exists){
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => LandingScreen()),
         );
       }else {
         // المستخدم جديد أو لم يسجل دخول
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => WelcomeScreen()),
         );
       }
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
