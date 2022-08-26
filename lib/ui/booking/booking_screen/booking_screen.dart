import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:initium_project/bussiness_logic/app_bloc/bloc.dart';
import 'package:initium_project/bussiness_logic/app_bloc/state.dart';
import 'package:initium_project/data/constant_data.dart';
import 'package:initium_project/shared/style.dart';
import 'package:initium_project/ui/common/custom_app_bar.dart';
import 'package:initium_project/ui/common/booked_listview.dart';
import 'package:initium_project/ui/common/custom_txt_field.dart';
import 'package:initium_project/ui/common/dialog_alert.dart';
import 'package:initium_project/ui/common/icon_counter.dart';
import 'package:initium_project/ui/common/register_btn.dart';
import 'package:initium_project/ui/common/snack_bar.dart';
import 'package:initium_project/ui/common/drop_down_list.dart';
import 'package:initium_project/ui/models/booked_data.dart';
import 'package:initium_project/ui/models/room_model.dart';
import 'package:initium_project/ui/resources/strings_manager.dart';

class BookingScreen extends StatefulWidget {
  final String branchName;
  const BookingScreen({Key? key, required this.branchName}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String dropDownItem = "single";
  final firstGuest = TextEditingController();
  final secondGuest = TextEditingController();
  final thirdGuest = TextEditingController();
  final fourthGuest = TextEditingController();

  final registerformKey = GlobalKey<FormState>();
  List<Room> availbleRooms = [];
  int choosedRoomDbId = 0;
  Room? currentRoom;

  @override
  void initState() {
    super.initState();
    AppBloc.get(context).getBranchRooms(widget.branchName);
    filterAvailableRooms("single");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final appBloc = AppBloc.get(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        "Booking Room",
        appBloc.bookedRooms.isNotEmpty ? const IconCounter() : const SizedBox(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: backIcon(context),
        ),
      ),
      body: SingleChildScrollView(
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (ctx, ch) => Form(
            key: registerformKey,
            child: Container(
              alignment: Alignment.center,
              child: Container(
                width: width * .8,
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: ScreenUtil().setHeight(30)),
                    Text("Welcom to ${widget.branchName} branch",
                        style: WelcomStyle),
                    if (appBloc.haveSale)
                      SizedBox(height: ScreenUtil().setHeight(30)),
                    if (appBloc.haveSale)
                      Text(AppStrings.sale, style: response14font),
                    SizedBox(
                        width: double.infinity, height: ScreenUtil().setHeight(30)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("room type:", style: response16font),
                        SizedBox(height: ScreenUtil().setHeight(8)),
                        DropDownList(
                          arrList: roomtypeList,
                          dropdownValue: dropDownItem,
                          fun: (value) {
                            setState(() {
                              dropDownItem = value!;
                              filterAvailableRooms(value);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(30)),
                    availbleRooms.length > 0
                        ? BlocBuilder<AppBloc, AppStates>(
                            builder: (context, state) => Column(
                              children: [
                                Text("enter Guest name", style: response16font),
                                SizedBox(height: ScreenUtil().setHeight(15)),
                                CustomFormTxtField(controller: firstGuest),
                                if (dropDownItem == "double")
                                  CustomFormTxtField(controller: secondGuest),
                                if (dropDownItem == "suit")
                                  Column(
                                    children: [
                                      CustomFormTxtField(controller: secondGuest),
                                      CustomFormTxtField(controller: thirdGuest),
                                    ],
                                  ),
                                if (dropDownItem == "fourth")
                                  Column(
                                    children: [
                                      CustomFormTxtField(controller: secondGuest),
                                      CustomFormTxtField(controller: thirdGuest),
                                      CustomFormTxtField(controller: fourthGuest),
                                    ],
                                  ),
                                SizedBox(height: ScreenUtil().setHeight(30)),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                  ),
                                  onPressed: () {
                                    if (registerformKey.currentState!.validate()) {
                                      for (var room in availbleRooms) {
                                        if (room.dbId == choosedRoomDbId) {
                                          setState(() {
                                            currentRoom = room;
                                          });
                                        }
                                      }
                                      if (currentRoom != null) {
                                        List<String> currentGuests = [];
                                        if (firstGuest.text.isNotEmpty) {
                                          currentGuests.add(firstGuest.text);
                                        }
                                        if (secondGuest.text.isNotEmpty) {
                                          currentGuests.add(secondGuest.text);
                                        }
                                        if (thirdGuest.text.isNotEmpty) {
                                          currentGuests.add(thirdGuest.text);
                                        }
                                        if (fourthGuest.text.isNotEmpty) {
                                          currentGuests.add(fourthGuest.text);
                                        }
                                        appBloc.updateBookedList(BookedRoomData(
                                          guests: currentGuests,
                                          databaseId: choosedRoomDbId,
                                          cost: appBloc.haveSale
                                              ? currentRoom!.cost * 0.95
                                              : currentRoom!.cost,
                                          roomType: dropDownItem,
                                          room: currentRoom!,
                                        ));
                                        setState(() {
                                          if (availbleRooms.length == 1) {
                                            availbleRooms = [];
                                          } else {
                                            availbleRooms.remove(currentRoom);
                                          }
                                          updateCurrentId();
                                          firstGuest.text = "";
                                          secondGuest.text = "";
                                          thirdGuest.text = "";
                                          fourthGuest.text = "";
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setHeight(30),
                                        vertical: ScreenUtil().setHeight(10)),
                                    child: Text("Add", style: response14font),
                                  ),
                                ),
                                SizedBox(height: ScreenUtil().setHeight(30)),
                              ],
                            ),
                          )
                        : Text("No rooms available in $dropDownItem",
                            style: response16font),
                    ButtonWidget('Book', () {
                      if (appBloc.bookedRooms.isNotEmpty) {
                        appBloc.sumAllCost();
                        alertMessage(
                            context,
                            "booking summary",
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hotel branch: ${widget.branchName}",
                                    style: response14font),
                                BookedListView(),
                                Text("Check cost: ${appBloc.allCost}",
                                    style: response14font),
                              ],
                            ), () {
                          // update room in data base
                          appBloc.updateRoom(widget.branchName);
                          //save this guest who booked in database (for sale)
                          appBloc.saveNewGuestDatabase();
                          //this guest have a sale
                          appBloc.guestHaveSale();
                          //filter available rooms again
                          filterAvailableRooms(dropDownItem);
                          //clear booking list
                          appBloc.clearBookedList();
                          //update current page data
                          AppBloc.get(context).getBranchRooms(widget.branchName);
                          filterAvailableRooms(dropDownItem);
                          Navigator.of(context).pop();
                        });
                      } else
                        customSnackBar(context, "Please add at least 1 room");
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  filterAvailableRooms(String filterType) {
    setState(() {
      availbleRooms = [];
      for (var item in AppBloc.get(context).branchRooms) {
        if (item.type == filterType && item.booked == false) {
          availbleRooms.add(item);
          choosedRoomDbId = item.dbId;
        }
      }
    });
  }

  updateCurrentId() {
    for (var item in availbleRooms) {
      setState(() {
        choosedRoomDbId = item.dbId;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstGuest.dispose();
    secondGuest.dispose();
    thirdGuest.dispose();
    fourthGuest.dispose();
  }
}
