import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_text_style.dart';

class CousstomBotton extends StatefulWidget {
  final String titell;
  final double? width;
  final void Function()? onTap;

  const CousstomBotton({
    super.key,
    required this.titell,
    this.onTap,
    this.width,
  });

  @override
  State<CousstomBotton> createState() => _CousstomBottonState();
}

class _CousstomBottonState extends State<CousstomBotton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (widget.onTap != null) widget.onTap!();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: widget.width ?? double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: _isPressed
              ? LinearGradient(
            colors: [Color(0xFF673AB7), Color(0xFF1A2B70)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : LinearGradient(
            colors: [Color(0xFF008080)
              , Color(0xFF162E7A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: _isPressed
              ? null
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: Offset(4, 4),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: Offset(-4, -4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.titell,
            style: AppTextStyle.Bold20Whit,
          ),
        ),
      ),
    );
  }
}
