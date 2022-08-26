import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:initium_project/bussiness_logic/app_bloc/bloc.dart';
import 'package:initium_project/bussiness_logic/app_bloc/state.dart';
import 'package:initium_project/data/constant_data.dart';
import 'package:initium_project/ui/common/custom_app_bar.dart';
import 'package:initium_project/ui/common/drop_down_list.dart';
import 'package:initium_project/ui/home/widgets/logo_widget.dart';
import 'package:initium_project/ui/home/widgets/logout_txt_btn.dart';
import 'package:initium_project/ui/common/snack_bar.dart';
import 'package:initium_project/ui/resources/assets_manager.dart';
import 'package:initium_project/ui/resources/strings_manager.dart';
import 'package:initium_project/ui/screens/rooms_status_screen.dart';
import 'package:initium_project/shared/navigate.dart';
import 'package:initium_project/shared/style.dart';
import 'package:initium_project/ui/home/widgets/login_txt_btn.dart';

import '../../booking/booking_screen/booking_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropDownItem = "Dahab";
  @override
  Widget build(BuildContext context) {
    final appcubit = AppBloc.get(context);
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: customAppBar(
            context,
            "Hotel",
            appcubit.isLoggedIn ? const LogoutTxtBtn() : const LoginTxtBtn(),
            const SizedBox()),
        body: SingleChildScrollView(
          child: ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (ctx, ch) => Column(
              children: [
                //hotel photo
                const LogoWidget(imgPath: ImageAssets.homeImage),
                SizedBox(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(30),
                ),
                //show a sale if this guest booked before
                if (appcubit.haveSale)
                  Text(AppStrings.sale, style: response14font),
                SizedBox(height: ScreenUtil().setHeight(30)),
                //branches dropdown list
                DropDownList(
                  arrList: branchesData,
                  dropdownValue: dropDownItem,
                  fun: (value) {
                    setState(() {
                      dropDownItem = value!;
                    });
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(60)),
                //rooms state button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        if (appcubit.isLoggedIn) {
                          navigateTo(context,
                              RoomsStatusScreen(branchName: dropDownItem));
                        } else {
                          customSnackBar(context, AppStrings.pleaseLoginFirst);
                        }
                      },
                      child: Text("room available", style: response14font),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(20)),
                    //booking page
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        if (appcubit.isLoggedIn) {
                          navigateTo(
                              context, BookingScreen(branchName: dropDownItem));
                        } else {
                          customSnackBar(context, AppStrings.pleaseLoginFirst);
                        }
                      },
                      child: Text(AppStrings.selectRoom, style: response14font),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
