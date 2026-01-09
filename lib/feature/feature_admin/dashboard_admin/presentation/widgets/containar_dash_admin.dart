import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainarDashAdmin extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double minHeight;
  final double maxHeight;
  final BorderRadius? borderRadius;
  final List<Color>? gradientColors;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const ContainarDashAdmin({
    Key? key,
    required this.text,
    this.onTap,
    this.minHeight = 150,
    this.maxHeight = double.infinity,
    this.borderRadius,
    this.gradientColors,
    this.padding,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius ?? BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        padding: padding ?? EdgeInsets.all(16.r),
        constraints: BoxConstraints(
          minHeight: minHeight.h,
          maxHeight: maxHeight.h,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: gradientColors ??
                [
                  Colors.blue.shade400,
                  Colors.blue.shade900,
                ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(4, 4),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(-4, -4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text.tr(), // ✅ جاهز للترجمة
            textAlign: TextAlign.center,
            style: textStyle ??
                TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
