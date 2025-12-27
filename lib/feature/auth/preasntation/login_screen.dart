import 'package:al_motafawiq/feature/auth/cubit_login/login_cubit.dart';
import 'package:al_motafawiq/feature/feature_admin/dashboard_admin/presentation/dashboard_admin_screen.dart';
import 'package:easy_localization/easy_localization.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ConfirmpasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController guardianPhoneController = TextEditingController();
  final TextEditingController cutyController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController PublicOrAlAzharController =
      TextEditingController();
  final TextEditingController WhichgradeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    ConfirmpasswordController.dispose();
    phoneController.dispose();
    cutyController.dispose();
    nameController.dispose();
    guardianPhoneController.dispose();
    PublicOrAlAzharController.dispose();
    WhichgradeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: [
                        Lottie.asset("assets/images/Login.json", height: 250.h),

                        SizedBox(height: 20.h),
                        CousttomTextFeld(
                          controller: nameController,
                          hintText: "Enter your name".tr(),
                          isPassword: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
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

                        CousttomTextFeld(
                          controller: ConfirmpasswordController,

                          hintText: "Confirm your password".tr(),
                          isPassword: true,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm your password";
                            }
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25.h),

                        CousttomTextFeld(
                          controller: phoneController,
                          hintText: "Enter your phone".tr(),
                          isPassword: false,
                          suffixIcon: Icon(
                            Icons.phone,
                            size: 30.r,
                            color: Colors.indigo,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone number is required";
                            }
                            if (value.length < 11) {
                              return "Enter a valid phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25.h),

                        CousttomTextFeld(
                          controller: guardianPhoneController,
                          hintText: "Enter your guardian phone".tr(),
                          isPassword: false,
                          suffixIcon: Icon(
                            Icons.phone,
                            size: 30.r,
                            color: Colors.indigo,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone number is required";
                            }
                            if (value.length < 11) {
                              return "Enter a valid phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25.h),

                        CousttomTextFeld(
                          controller: WhichgradeController,
                          hintText: "Enter your Which grade".tr(),
                          isPassword: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Which grade is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25.h),

                        CousttomTextFeld(
                          controller: PublicOrAlAzharController,
                          hintText: "Enter your Public or Al-Azhar".tr(),
                          isPassword: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Public or Al-Azhar is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25.h),
                        CousttomTextFeld(
                          controller: cutyController,
                          hintText: "Enter your city".tr(),
                          isPassword: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "City is required";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 25.h),

                        BlocListener<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginLoading) {
                              showLoadingDialog(context);
                            } else if (state is LoginSuccessAdmin) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardAdminScreen(),
                                ),
                                (route) => false,
                              );
                            } else if (state is LoginSuccessUser) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LandingScreen(),
                                ),
                                (route) => route.isFirst,
                              );
                            } else if (state is LoginError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message ?? 'حدث خطأ'),
                                ),
                              );
                            }
                          },
                          child: CousstomBotton(
                            titell: "Register".tr(),

                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                final confirmPassword =
                                    ConfirmpasswordController.text.trim();
                                final name = nameController.text.trim();
                                final phone = phoneController.text.trim();
                                final guardianPhone = guardianPhoneController
                                    .text
                                    .trim();
                                final city = cutyController.text.trim();
                                final PublicOrAlAzhar =
                                    PublicOrAlAzharController.text.trim();
                                final Whichgrade = WhichgradeController.text
                                    .trim();

                                // بعدين نطبع البيانات
                                // print('Email: $email');
                                // print('Password: $password');
                                // print('Confirm Password: $confirmPassword');
                                // print('Name: $name');
                                // print('Phone: $phone');
                                // print('Guardian Phone: $guardianPhone');
                                // print('City: $city');
                                context.read<LoginCubit>().Login(
                                  emailAddress: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  confirmPassword: ConfirmpasswordController
                                      .text
                                      .trim(),
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  guardianPhone: guardianPhoneController.text
                                      .trim(),
                                  city: cutyController.text.trim(),
                                  WhichGrade: WhichgradeController.text.trim(),
                                  PublicOrAlAzhar: PublicOrAlAzharController
                                      .text
                                      .trim(),
                                );

                                if (_formKey.currentState!.validate()) {
                                  // ✅ كل الداتا صح
                                  final email = emailController.text.trim();
                                  final password = passwordController.text
                                      .trim();
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 25.h),

                        CoustomLanguage(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
