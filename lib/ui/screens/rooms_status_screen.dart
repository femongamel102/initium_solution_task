import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initium_project/bussiness_logic/app_bloc/bloc.dart';
import 'package:initium_project/bussiness_logic/app_bloc/state.dart';
import 'package:initium_project/shared/style.dart';
import 'package:initium_project/ui/common/custom_app_bar.dart';

class RoomsStatusScreen extends StatelessWidget {
  final String branchName;
  const RoomsStatusScreen({Key? key, required this.branchName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc.get(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        branchName,
        const SizedBox(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: backIcon(context),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AppBloc, AppStates>(builder: (context, state) {
          appBloc.getBranchRooms(branchName);
          return ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (ctx, ch) => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: appBloc.branchRooms.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.5),
                    borderRadius: BorderRadius.circular(15),
                    border: const Border.fromBorderSide(
                        BorderSide(width: 1.5, color: Colors.black54))),
                child: ListTile(
                  leading: Text(
                      appBloc.branchRooms[index].roomNumber.toString(),
                      style: response14font),
                  title: Text(
                      appBloc.branchRooms[index].booked
                          ? "Booked"
                          : "Available",
                      style: response16font),
                  subtitle: Text(appBloc.branchRooms[index].type.toString(),
                      style: response14font),
                  trailing: Text(
                      appBloc.branchRooms[index].booked
                          ? "15/3/2022 ${appBloc.branchRooms[index].bookto}"
                          : "${appBloc.branchRooms[index].cost}LE",
                      style: response14font),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
