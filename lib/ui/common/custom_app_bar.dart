import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:initium_project/shared/style.dart';

AppBar customAppBar(context,String text,Widget action, Widget leading) {
  return AppBar(
    centerTitle: true,
    leading: leading,
    // the title of the app bar
    title:ScreenUtilInit(minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx , ch) => Text(
      '$text',
      style: appbarTitleStyle.copyWith(fontSize:ScreenUtil().setSp(22),),
    ),),
    //to stop back button in the app bar
    actions: [
      action,
    ],
    //make app bar with white background and no elevation
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
Widget backIcon(context){
  return ScreenUtilInit(minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx , ch) => Icon(Icons.arrow_back_ios,size:ScreenUtil().setSp(20),color: darkColor));
}