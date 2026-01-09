import 'package:al_motafawiq/core/theme/app_text_style.dart';
import 'package:al_motafawiq/core/widgets/cousstom_botton.dart';
import 'package:al_motafawiq/core/widgets/row_text.dart';
import 'package:al_motafawiq/feature/feature_admin/core/wigets/cousstom_student_app_Bar.dart';
import 'package:al_motafawiq/feature/feature_admin/core/wigets/cousstom_student_containr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/model/student_model.dart';
import '../../../../core/widgets/animate_gradient.dart';
import '../../core/wigets/student_search_bar.dart';
import '../../data_get_student/cubit/get_data_studint_cubit.dart';
import '../../student_details_screen/presentation/student_details_screen.dart';

class StudentsDataFirstSecondaryScreen extends StatefulWidget {
  const StudentsDataFirstSecondaryScreen({super.key});

  @override
  State<StudentsDataFirstSecondaryScreen> createState() =>
      _StudentsDataFirstSecondaryScreenState();
}

class _StudentsDataFirstSecondaryScreenState
    extends State<StudentsDataFirstSecondaryScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ده بيخلي الكيبورد يقفل لو ضغطت برة TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            AnimateGradientu(child: Scaffold()),

            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80.h), // خلي مساحة للزرار

                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0.r),
                      child: CousstomStudentAppBar(
                        tittel: "بيانات الطلاب في الصف الأول الثانوي👥",
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: StudentSearchBar(
                        controller: searchController,
                        onChanged: (value) {
                          // هنا هتحط فلترة الطلاب
                          setState(() {}); // ✅ يعيد بناء القائمة بعد كل كتابة
                          print(value);
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Padding(
                      padding: EdgeInsets.all(16.0.r),
                      child: Column(
                        children: [
                          BlocBuilder<GetDataStudintCubit, GetDataStudintState>(
                            builder: (context, state) {
                              if (state is StudentsLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is StudentsError) {
                                return Center(
                                  child: Text("حدث خطأ: ${state.message}"),
                                );
                              } else if (state is StudentsSuccess) {
                                final students = state.students
                                  ..sort(
                                    (a, b) =>
                                        b.createdAt!.compareTo(a.createdAt!),
                                  ); // الجديد يظهر أول

                                List<StudentModel> displayedStudents;
                                if (searchController.text.isEmpty) {
                                  displayedStudents =
                                      students; // كل الطلاب لو البحث فاضي
                                } else {
                                  final query = searchController.text
                                      .toLowerCase();
                                  displayedStudents = students.where((student) {
                                    return student.name.toLowerCase().contains(
                                          query,
                                        ) ||
                                        student.phone.toLowerCase().contains(
                                          query,
                                        ) ||
                                        student.city.toLowerCase().contains(
                                          query,
                                        );
                                  }).toList();
                                }

                                if (students.isEmpty) {
                                  // لو مفيش طلاب أصلاً
                                  return Column(
                                    children: [
                                      SizedBox(height: 40.h),
                                      Lottie.asset(
                                        'assets/lottie/empty.json',
                                        height: 200.h,
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        "لا يوجد طلاب مسجلين حاليًا",
                                        style: AppTextStyle.Bold20Whit,
                                      ),
                                    ],
                                  );
                                } else if (displayedStudents.isEmpty) {
                                  // لو البحث الفاضي أو لم يُعثر على طلاب مطابقين
                                  return Column(
                                    children: [
                                      SizedBox(height: 40.h),
                                      Lottie.asset(
                                        'assets/lottie/search.json',
                                        height: 200.h,
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        "لم يتم العثور على طلاب مطابقين",
                                        style: AppTextStyle.Bold20Whit,
                                      ),
                                    ],
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: displayedStudents.length,
                                  itemBuilder: (context, index) {
                                    final student = displayedStudents[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                StudentDetailsScreen(
                                                  student: student,
                                                  name: student.name,
                                                  grade: student.WhichGrade,
                                                  guardianPhone: student.guardianPhone,
                                                  phone: student.phone,
                                                  PublicOrAlAzhar:
                                                  student.PublicOrAlAzhar,
                                                  city: student.city,

                                                  WatchedVideos: 'احمججج',
                                                  dateOfBirth: DateTime(20000),
                                                  address: 'hpl,]d', WhichGrade: student.WhichGrade,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 25.h),
                                        child: CousstomStudentContainr(
                                          name: student.name,
                                          grade: student.WhichGrade,
                                          guardianPhone: student.guardianPhone,
                                          phone: student.phone,
                                          PublicOrAlAzhar:
                                              student.PublicOrAlAzhar,
                                          city: student.city,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20.h,
              left: 16.w,
              right: 16.w,
              child: CousstomBotton(
                titell: "رجوع",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
