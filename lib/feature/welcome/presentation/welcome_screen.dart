import 'package:al_motafawiq/feature/auth/cubit_login/login_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/app_text_style.dart';
import '../../../core/widgets/animate_gradient.dart';
import '../../../core/widgets/cousstom_botton.dart';
import '../../../core/widgets/coustom_language.dart';
import '../../auth/preasntation/register_screen.dart';
import '../../auth/preasntation/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),

                    Lottie.asset("assets/images/Login.json", height: 250.r),
                    SizedBox(height: 20.h),

                    Text(
                      "Welcome Back".tr(), // ✅ تم إضافة الترجمة
                      style: AppTextStyle.Bold30Whit,
                    ),
                    SizedBox(height: 180.h),

                    CousstomBotton(
                      titell: 'Login'.tr(), // ✅ ترجمة
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => LoginCubit(),
                              child: AuthScreen(),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 25.h),

                    CousstomBotton(
                      titell: 'Register'.tr(), // ✅ ترجمة
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => LoginCubit(),
                              child: LoginScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30.h),

                    CoustomLanguage(), // زر تغيير اللغة

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
