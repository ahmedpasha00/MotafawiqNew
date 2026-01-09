import 'package:al_motafawiq/core/widgets/cousstom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/model/student_model.dart';
import '../../../../core/widgets/animate_gradient.dart';
import '../../../../core/theme/app_text_style.dart';

class StudentDetailsScreen extends StatelessWidget {
  final StudentModel student; // لازم يكون هنا

  final String name;
  final String grade;
  final String phone;
  final String guardianPhone;
  final String city;
  final String PublicOrAlAzhar;
  final String WhichGrade;
  final String WatchedVideos;           // بيانات إضافية افتراضية
  final DateTime dateOfBirth;   // بيانات إضافية افتراضية
  final String address;         // بيانات إضافية افتراضية

  const StudentDetailsScreen({
    super.key,
    required this.name,
    required this.grade,
    required this.phone,
    required this.guardianPhone,
    required this.city,
    required this.PublicOrAlAzhar,
    required this.WhichGrade,
    required this.WatchedVideos,
    required this.dateOfBirth,
    required this.address, required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية المتحركة
          AnimateGradientu(child: Scaffold()),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان الصفحة
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      "تفاصيل الطالب: $name",
                      style: AppTextStyle.Bold25Whit,
                    ),
                  ),


                  SizedBox(height: 20.h),

                  // بطاقة بيانات الطالب
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: LinearGradient(
                      colors: [
                        Color(0xFF2E3A59), // أزرق داكن هادي
                        Colors.blue.shade400,
                        Colors.blue.shade900,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10,
                        blurRadius: 15,
                        offset: Offset(0, 3),
                      ),
                    ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoRow("الاسم", name),
                        infoRow("الصف", grade),
                        infoRow("الصف الدراسي الفعلي", WhichGrade),
                        infoRow("هاتف الطالب", phone),
                        infoRow("هاتف ولي الأمر", guardianPhone),
                        infoRow("المدينة", city),
                        infoRow("نوع التعليم", PublicOrAlAzhar),
                        infoRow("الفيديوهات التي تم مشاهدتها", WatchedVideos),
                        infoRow("تاريخ الميلاد", "${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}"),
                        infoRow("العنوان", address),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // زر العودة
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                     child: CousstomBotton(titell: "رجوع للخلف",
                     onTap: (){
                       Navigator.pop(context);

                     },
                     ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لعرض صف معلومات
  Widget infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: AppTextStyle.Bold20Whit,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: AppTextStyle.Bold20Whit,
            ),
          ),
        ],
      ),
    );
  }
}
