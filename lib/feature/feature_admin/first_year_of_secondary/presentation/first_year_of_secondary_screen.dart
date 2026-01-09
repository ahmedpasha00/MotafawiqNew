import 'package:al_motafawiq/core/widgets/cousstom_botton.dart';
import 'package:al_motafawiq/core/widgets/student_grades/student_grades_class.dart';
import 'package:al_motafawiq/feature/feature_admin/data_get_student/cubit/get_data_studint_cubit.dart';
import 'package:al_motafawiq/feature/feature_admin/data_get_student/repo_which_grade/repo_which_grade_screen.dart';
import 'package:al_motafawiq/feature/feature_admin/students_data_first_secondary/presentation/first_veiw_vedio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/animate_gradient.dart';
import '../../dashboard_admin/presentation/widgets/containar_dash_admin.dart';
import '../../setting_admin/presentation/setting_admin_screen.dart';
import '../../students_data_first_secondary/presentation/students_data_first_secondary_screen.dart';
import '../../upload_videos/presentation/upload_videos_screen.dart';

class FirstYearOfSecondaryScreen extends StatelessWidget {
  const FirstYearOfSecondaryScreen({super.key});

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
                      text: 'بيانات الطلاب في الصف الاول الثانوي',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) => GetDataStudintCubit(repo: RepoWhichGradeScreen(firestore: FirebaseFirestore.instance
                                  ),
                                  )..loadStudint(Grades.first),
                                  child: StudentsDataFirstSecondaryScreen(),
                                ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 30.h),

                    ContainarDashAdmin(
                      text: 'رفع الفيديوهات',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadVideosScreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 30.h),

                    ContainarDashAdmin(
                      text: 'مشاهده الفيديوهات التي تم رفعها ',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FirstViewVideo(),
                          ),
                        );
                      },
                    ),
                    // ContainarDashAdmin(text: 'تعديل الفيديوهات',
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingAdminScreen()));
                    //   },
                    // ),
                    SizedBox(height: 160.h),

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
