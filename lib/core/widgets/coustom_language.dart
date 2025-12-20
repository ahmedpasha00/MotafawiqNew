import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_text_style.dart';

class CoustomLanguage extends StatelessWidget {
  const CoustomLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(

      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon:  Icon(Icons.language,
            size: 30.r,

            color: Colors.deepPurple,

          ),

          onPressed: () {
            if (context.locale.languageCode == 'ar') {
              context.setLocale(const Locale('en'));
            } else {
              context.setLocale(const Locale('ar'));
            }
          },
        ),

        Text("Change Language".tr(),
          style: AppTextStyle.Bold20Whit,
        ),

      ],

    );
  }
}
