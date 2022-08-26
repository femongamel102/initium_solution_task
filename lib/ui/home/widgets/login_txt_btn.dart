import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:initium_project/shared/navigate.dart';
import 'package:initium_project/shared/style.dart';

import '../../login/login_screen/login_screen.dart';

class LoginTxtBtn extends StatelessWidget {
  const LoginTxtBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          navigateTo(context, RegisterScreen());
        },
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (ctx , ch) => Text(
            "Login",
            style: loginTextStyle,
          ),
        ));
  }
}
