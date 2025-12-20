import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/screenutil_init.dart';

class AnimateGradientu extends StatelessWidget {
  const AnimateGradientu({super.key,  required Scaffold child, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Color(0xFF0B1D51), // أزرق داكن أساسي
          Color(0xFF102C6D), // أزرق ملكي داكن
          Color(0xFF1A3A8C), // أزرق ليل متدرج
          Color(0xFF0D1F4F), // أزرق كحلي عميق
        ],
        secondaryColors: const [
          Color(0xFF09174A), // أزرق غامق جداً
          Color(0xFF132867), // أزرق سمائي غامق
          Color(0xFF1B3B8F), // أزرق ليل مضيء
          Color(0xFF0C1B4D), // أزرق كحلي غامق
        ],

      ),
    );
  }
}
