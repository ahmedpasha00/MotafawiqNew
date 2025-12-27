import 'package:al_motafawiq/feature/feature_admin/dashboard_admin/presentation/dashboard_admin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/animate_gradient.dart';
import '../../../core/widgets/cousstom_botton.dart';
import '../../../core/widgets/coustom_language.dart';
import '../../../core/widgets/cousttom_text_feld.dart';
import '../../../core/widgets/show_loading_dialog.dart';
import '../../landing/presentation/landing_screen.dart';
import '../cubit/register_cubit.dart';
import '../data_register/repo_register/repo_register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(
        AuthRepo(FirebaseAuth.instance, FirebaseFirestore.instance),
      ),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            showLoadingDialog(context);
          }
          else if (state is RegisterSuccessAdmin) {
            if (Navigator.canPop(context)) Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DashboardAdminScreen()), // صفحة الأدمين
            );
          }
          else if (state is RegisterSuccess) {
            if (Navigator.canPop(context)) Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LandingScreen()),
            );
          } else if (state is RegisterError) {
            if (Navigator.canPop(context)) Navigator.pop(context);

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text('خطأ'),
                content: Text(
                  state.message ?? 'الإيميل أو كلمة المرور غير صحيحة',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('حسناً'),
                  ),
                ],
              ),
            );
          }
        },
        child: Builder(
          builder: (context) {
            // ✅ Builder هنا يضمن إن الـ context مربوط بالـ BlocProvider
            return Scaffold(
              body: Stack(
                children: [
                  AnimateGradientu(child: Scaffold()),

                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Lottie.asset(
                                "assets/images/Login.json",
                                height: 250.h,
                              ),

                              SizedBox(height: 25.h),
                              CousttomTextFeld(
                                controller: emailController,
                                hintText: "Enter your Email".tr(),
                                isPassword: false,
                                suffixIcon: Icon(
                                  Icons.email_sharp,
                                  size: 30.r,
                                  color: Colors.indigo,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is required";
                                  }
                                  if (!value.contains('@')) {
                                    return "Enter a valid '@' email";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.h),

                              CousttomTextFeld(
                                controller: passwordController,
                                hintText: "Enter your Password".tr(),
                                isPassword: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password is required";
                                  }
                                  if (value.length < 8) {
                                    return "Password must be at least 8 characters";
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: 25.h),

                              CousstomBotton(
                                titell: "Login".tr(),
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    // هنا الـ context مظبوط
                                    context.read<RegisterCubit>().loginUser(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    );
                                  }
                                },
                              ),

                              SizedBox(height: 15.h),
                              CoustomLanguage(),
                            ],
                          ),
                        ),
                      ),
                    ),
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
