import 'package:al_motafawiq/core/widgets/container_dashboard.dart';
import 'package:al_motafawiq/feature/feature_admin/dashboard_admin/cubit/total_students_cubit.dart';
import 'package:al_motafawiq/feature/feature_admin/dashboard_admin/data/repo/total_students_repo.dart';
import 'package:al_motafawiq/feature/feature_admin/dashboard_admin/presentation/widgets/containar_dash_admin.dart';
import 'package:al_motafawiq/feature/feature_admin/first_year_of_secondary/presentation/first_year_of_secondary_screen.dart';
import 'package:al_motafawiq/feature/feature_admin/second_year_of_secondary/presentation/second_year_of_secondary_screen.dart';
import 'package:al_motafawiq/feature/feature_admin/setting_admin/presentation/setting_admin_screen.dart';
import 'package:al_motafawiq/feature/feature_admin/third_year_of_secondary/presentation/third_year_of_secondary_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/animate_gradient.dart';

class DashboardAdminScreen extends StatelessWidget {
  const DashboardAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TotalStudentsCubit(
        repository: TotalStudentsRepo(firestore: FirebaseFirestore.instance),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            AnimateGradientu(child: Scaffold()),

            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: SafeArea(
                  child: Column(
                    children: [
                      ContainerDashboard(
                        minHeight: 200,
                        borderRadius: BorderRadius.circular(24.r),
                        gradientColors: [
                          Color(0xFF2E3A59), // أزرق داكن هادي
                          Colors.blue.shade400,
                          Colors.blue.shade900,
                        ],
                        child: Column(
                          children: [
                            Text(
                              "عدد الطلاب",
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            BlocBuilder<TotalStudentsCubit, TotalStudentsState>(
                              builder: (context, state) {
                                if (state is TotalStudentsLoading) {
                                  return CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                } else if (state is TotalStudentsSuccess) {
                                  return Text(
                                    state.totalStudents.toString(),
                                    style: AppTextStyle.Bold30Whit,
                                  );
                                } else if (state is TotalStudentsError) {
                                  return Text(
                                    "خطأ",
                                    style: AppTextStyle.Bold30Whit,
                                  );
                                } else {
                                  return Text(
                                    "0",
                                    style: AppTextStyle.Bold30Whit,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                     SizedBox(height: 30.h,),
                     ContainarDashAdmin(text: 'الصف الاول الثانوي ',
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstYearOfSecondaryScreen()));
                     },
                     ),
                      SizedBox(height: 30.h,),
                      ContainarDashAdmin(text: 'الصف الثاني الثانوي ',
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondYearOfSecondaryScreen()));
                        },
                      ),SizedBox(height: 30.h,),
                      ContainarDashAdmin(text: 'الصف الثالث الثانوي ',
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirdYearOfSecondaryScreen()));
                        },
                      ),
                      SizedBox(height: 30.h,),
                      ContainarDashAdmin(text: '⚙️ الاعدادات',
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingAdminScreen()));
                        },
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
