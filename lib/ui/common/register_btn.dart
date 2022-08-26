import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:initium_project/shared/style.dart';

class ButtonWidget extends StatelessWidget {
  final String bText;
  final function;
  const ButtonWidget(this.bText, this.function, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(

        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setHeight(38),
            vertical: ScreenUtil().setHeight(10)),
        decoration: customDecor,
        child: Text(
          "$bText",
          style: enrollstyle,
        ),
      ),
    );
  }
}
