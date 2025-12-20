import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showLoadingDialog(BuildContext context, {String? text}) {
  showDialog(
    barrierDismissible: true, // المستخدم مش يقدر يقفل
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 👇 تحط لوتي هنا لو تحب
            Lottie.asset(
              'assets/lottie/Login.json', // حط ملف لوتي من عندك
              width: 100,
              height: 100,
              repeat: true,
            ),
            SizedBox(height: 20),
            Text(
              text ?? "Loading...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
