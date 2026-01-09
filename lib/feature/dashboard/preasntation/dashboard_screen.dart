import 'package:al_motafawiq/core/theme/app_text_style.dart';
import 'package:al_motafawiq/core/widgets/container_dashboard.dart';
import 'package:al_motafawiq/core/widgets/cousstom_botton.dart';
import 'package:al_motafawiq/core/widgets/row_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/animate_gradient.dart';
import 'cubit/dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0.r),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text("Dashboard".tr(), style: AppTextStyle.Bold25Whit),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: 400.h,
                        maxHeight: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: LinearGradient(
                          colors: [Colors.brown.shade800, Colors.blue.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(4, 4),
                            blurRadius: 8,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            offset: Offset(-4, -4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(29.0.r),
                        child: BlocBuilder<DashboardCubit, DashboardState>(
                          builder: (context, state) {
                            if (state is DashboardLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }

                            if (state is DashboardSuccess) {
                              final student = state.student;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 20.h),
                                  RowText(
                                    Text: student.name,
                                    Text1: "Enter your Full Name".tr(),
                                  ),
                                  Divider(color: Colors.white54, thickness: 1),
                                  SizedBox(height: 20.h),
                                  RowText(
                                    Text: student.WhichGrade,
                                    Text1: "Enter the course".tr(),
                                  ),
                                  SizedBox(height: 20.h),
                                  Divider(color: Colors.white54, thickness: 1),
                                  RowText(
                                    Text: student.PublicOrAlAzhar,
                                    Text1: "Education Type".tr(),
                                  ),
                                  SizedBox(height: 20.h),
                                  Divider(color: Colors.white54, thickness: 1),
                                  RowText(
                                    Text: student.phone,
                                    Text1:  "Enter your phone".tr(),
                                  ),
                                  SizedBox(height: 20.h),
                                  Divider(color: Colors.white54, thickness: 1),
                                  RowText(
                                    Text: student.guardianPhone,
                                    Text1: "Enter your guardian phone".tr(),
                                  ),
                                  SizedBox(height: 20.h),
                                  Divider(color: Colors.white54, thickness: 1),
                                  RowText(
                                    Text: student.city,
                                    Text1: "City".tr(),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              );
                            }

                            if (state is DashboardError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: AppTextStyle.Bold20Whit,
                                ),
                              );
                            }

                            return SizedBox();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ContainerDashboard(
                      minHeight: 200,
                      borderRadius: BorderRadius.circular(24.r),
                      gradientColors: [
                        Colors.purple.shade800,
                        Color(0xFF2E3A59),
                        Color(0xFF4E5D78),
                      ],
                      child: Column(
                        children: [
                          Text(
                            "Hello Dashboard".tr(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Custom container content goes here".tr(),
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ContainerDashboard(
                      minHeight: 200,
                      borderRadius: BorderRadius.circular(24.r),
                      gradientColors: [
                        Color(0xFF2E3A59),
                        Color(0xFF4E5D78),
                        Colors.pink.shade400
                      ],
                      child: Column(
                        children: [
                          Text(
                            "عدد النقاط".tr(),
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "0",
                            style: AppTextStyle.Bold30Whit,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CousstomBotton(
                      titell: "Back to Home".tr(),
                      onTap: () {
                        Navigator.pop(context);
                      },
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
}
