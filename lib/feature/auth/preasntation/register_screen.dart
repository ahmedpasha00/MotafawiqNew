import 'package:al_motafawiq/core/widgets/show_loading_dialog.dart';
import 'package:al_motafawiq/feature/auth/cubit/auth_cubit.dart';
import 'package:al_motafawiq/feature/auth/preasntation/login_screen.dart';
import 'package:al_motafawiq/feature/landing/presentation/landing_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/app_text_style.dart';
import '../../../core/widgets/animate_gradient.dart';
import '../../../core/widgets/cousstom_botton.dart';
import '../../../core/widgets/coustom_language.dart';
import '../../../core/widgets/cousttom_text_feld.dart';
import '../cubit_login/login_cubit.dart';

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
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showLoadingDialog(context); // يظهر Loading
          } else if (state is LoginSuccess) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LandingScreen()),
            );
          } else if (state is LoginError) {
            // يقفل اللودينج لو مفتوح
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            // يظهر الخطأ على الشاشة
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  AlertDialog(
                    title: Text('خطأ'),
                    content: Text(
                      state.message ?? 'الإيميل أو كلمة المرور غير صحيحة',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('حسناً'),
                      ),
                    ],
                  ),
            );
          }
        },
        child: Scaffold(
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

                          BlocListener<LoginCubit , LoginState>(
                            listener: (context, state) {
                              if(state is LoginLoading){
                                showLoadingDialog(context);
                              }else if(state is LoginSuccess){
                                print(FirebaseAuth.instance.currentUser?.email);

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => LandingScreen()),
                                      (route) => route.isFirst,
                                );
                              } else if (state is LoginError) {
                                Navigator.pop(context); // يقفل اللودينج
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message ?? 'خطأ')),
                                );
                              }
                            },
                            child: CousstomBotton(
                              titell: "Login".tr(),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().LoginOnly(
                                    emailAddress: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                }

                                // ✅ كل الداتا صح
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                // print(email);
                                // print(password);
                              },
                            ),
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
        ),
      ),
    );
  }
}
