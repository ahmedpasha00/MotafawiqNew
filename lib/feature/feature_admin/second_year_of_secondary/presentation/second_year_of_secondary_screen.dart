import 'package:al_motafawiq/core/widgets/student_grades/student_grades_class.dart';
import 'package:al_motafawiq/feature/feature_admin/core/wigets/cousstom_student_app_Bar.dart';
import 'package:al_motafawiq/feature/feature_admin/data_get_student/cubit/get_data_studint_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/animate_gradient.dart';
import '../../../../core/widgets/cousstom_botton.dart';
import '../../core/wigets/cousstom_student_containr.dart';
import '../../core/wigets/student_search_bar.dart';
import '../../dashboard_admin/presentation/widgets/containar_dash_admin.dart';
import '../../data_get_student/repo_which_grade/repo_which_grade_screen.dart';
import '../../students_data_second_secondary/presentation/students_data_second_secondary_screen.dart';
import '../../upload_videos_2/presentation/upload_videos_2_screen.dart';

class SecondYearOfSecondaryScreen extends StatefulWidget {
  const SecondYearOfSecondaryScreen({super.key});

  @override
  State<SecondYearOfSecondaryScreen> createState() =>
      _SecondYearOfSecondaryScreenState();
}

class _SecondYearOfSecondaryScreenState
    extends State<SecondYearOfSecondaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),

          SizedBox(height: 30.h),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  children: [
                    ContainarDashAdmin(
                      text: 'بيانات الطلاب في الصف الثاني الثانوي',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => GetDataStudintCubit(
                                repo: RepoWhichGradeScreen(
                                  firestore: FirebaseFirestore.instance,
                                ),
                              )..loadStudint(Grades.second),
                              child: StudentsDataSecondSecondaryScreen(),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 30.h),

                    ContainarDashAdmin(
                      text: 'مشاهده الفيديوهات التي تم رفعها للصف الثاني الثانوي',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadVideos2Screen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 30.h),

                    // ContainarDashAdmin(text: 'تعديل الفيديوهات',
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingAdminScreen()));
                    //   },
                    // ),
                    SizedBox(height: 290.h),

                    CousstomBotton(
                      titell: "الرجوع للصفحة الرئيسية",
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
