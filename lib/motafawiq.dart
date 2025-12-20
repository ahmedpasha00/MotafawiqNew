import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/widgets/animate_gradient.dart';
import 'feature/splash/splash_screen.dart';

class Motafawiq extends StatelessWidget {
  const Motafawiq({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(

          // scaffoldBackgroundColor: Color(0xFF1E2A38), // كحلي داكن جذاب
          primaryColor: Color(0xFF3F51B5), // أزرق جذاب للأزرار وAppBar
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF3F51B5),
            foregroundColor: Colors.white),
        ),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,

        home: SplashScreen(),
      ),
    );
  }
}
