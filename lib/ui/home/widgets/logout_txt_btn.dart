import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:initium_project/bussiness_logic/app_bloc/bloc.dart';
import 'package:initium_project/shared/style.dart';
import 'package:initium_project/ui/common/dialog_alert.dart';

class LogoutTxtBtn extends StatelessWidget {
  const LogoutTxtBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, ch) => TextButton(
        onPressed: () {
          //are you sure dialog
          alertMessage(
              context,
              'hint',
              Text("Are you sure ? you can not book until login !",
                  style: response14font), () {
            AppBloc.get(context).changeLoggedIn();
            Navigator.of(context).pop();
          });
        },
        child: Text(
          "Logout",
          style: loginTextStyle,
        ),
      ),
    );
  }
}