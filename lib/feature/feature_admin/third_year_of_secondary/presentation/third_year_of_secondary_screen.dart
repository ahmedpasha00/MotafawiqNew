import 'package:al_motafawiq/core/widgets/student_grades/student_grades_class.dart';
import 'package:al_motafawiq/feature/feature_admin/data_get_student/cubit/get_data_studint_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/animate_gradient.dart';
import '../../../../core/widgets/cousstom_botton.dart';
import '../../dashboard_admin/presentation/widgets/containar_dash_admin.dart';
import '../../data_get_student/repo_which_grade/repo_which_grade_screen.dart';
import '../../students_data_third_secondary/presentation/students_data_third_secondary_screen.dart';
import '../../upload_videos_3/presentation/upload_videos_3_screen.dart';

class ThirdYearOfSecondaryScreen extends StatelessWidget {
  const ThirdYearOfSecondaryScreen({super.key});

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
                              create: (context) =>
                                  GetDataStudintCubit(
                                    repo: RepoWhichGradeScreen(
                                      firestore: FirebaseFirestore.instance,
                                    ),
                                  )..loadStudint(
                                    Grades.third
                                  ), // مهم: استدعي loadStudint
                              child: StudentsDataThirdSecondaryScreen(),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 30.h),

                    ContainarDashAdmin(
                      text: 'مشاهده الفيديوهات التي تم رفعها للصف الثالث الثانوي',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadVideos3Screen(),
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
