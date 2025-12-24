import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CousttomTextFeld extends StatefulWidget {
  final String hintText;
  final void Function()? onTap;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator; // 👈 مهم

  const CousttomTextFeld({
    super.key,
    required this.hintText,
    this.onTap,
    this.controller,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
  });

  @override
  State<CousttomTextFeld> createState() => _CousttomTextFeldState();
}

class _CousttomTextFeldState extends State<CousttomTextFeld> {
  bool _hidePassword = true; // علشان نتحكم في إظهار/إخفاء الباسورد
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TextFormField(
        style: TextStyle(
          fontSize: 20.sp, // حجم الخط
          fontWeight: FontWeight.bold, // اختياري
          color: Colors.black,
        ),

        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _hidePassword : false,
        controller: widget.controller,
        validator: widget.validator,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.h, // تتحكم في الارتفاع
            horizontal: 10.w, // تتحكم في المسافة الجانبية
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.blueAccent, // اللون اللي هيظهر عند الضغط
              width: 2.w, // سمك الخط
            ),
          ),
          labelText: widget.hintText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never, // السلوك الطبيعي
          floatingLabelStyle: TextStyle(
            color: Colors.black, // لون النص لما يطفو فوق
            fontSize: 20.sp, // حجم النص لما يطفو فوق
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: Colors.indigo[50],
      
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.blueAccent,
                    size: 30.r,
                  ),
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                )
              : widget.suffixIcon,
      
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
        ),
      ),
    );
  }
}
