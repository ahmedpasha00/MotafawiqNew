import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/row_text.dart';

class CousstomStudentContainr extends StatelessWidget {
  final String name;
  final String grade;
  final String guardianPhone;
  final String phone;
  final String PublicOrAlAzhar;
  final String city;
  final void Function()? onTap;
  const CousstomStudentContainr({
    super.key,
    required this.name,
    required this.grade,
    required this.guardianPhone,
    required this.phone,
    required this.PublicOrAlAzhar,
    required this.city, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.r),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowText(Text: "اسم الطالب:", Text1:name),
            SizedBox(height: 25),
            RowText(Text: "الصف:", Text1: grade),
            SizedBox(height: 25),

            RowText(Text: "رقم ولي الامر:", Text1: guardianPhone),
            SizedBox(height: 25),
            RowText(Text: "رقم الطالب:", Text1: phone),
            SizedBox(height: 25),
            RowText(Text: "عام ولا ازهر:", Text1: PublicOrAlAzhar),
            SizedBox(height: 25),
            RowText(Text: "المدينه او البلده:", Text1: city),
          ],
        ),
      ),
    );
  }
}
