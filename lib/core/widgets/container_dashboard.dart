import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerDashboard extends StatelessWidget {
  final double minHeight;
  final double maxHeight;
  final BorderRadius? borderRadius;
  final List<Color>? gradientColors;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const ContainerDashboard({
    Key? key,
    this.minHeight = 400,          // القيمة الافتراضية
    this.maxHeight = double.infinity,
    this.borderRadius,
    this.gradientColors,
    this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: minHeight.h,
        maxHeight: maxHeight.h,
      ),
      padding: padding ?? EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: gradientColors ?? [Colors.brown.shade800, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }
}
