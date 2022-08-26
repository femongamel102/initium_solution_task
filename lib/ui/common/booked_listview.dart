import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initium_project/bussiness_logic/app_bloc/bloc.dart';
import 'package:initium_project/bussiness_logic/app_bloc/state.dart';
import 'package:initium_project/shared/style.dart';
class BookedListView extends StatelessWidget {
  const BookedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: BlocBuilder<AppBloc, AppStates>(
        builder: (context, state) {
          final bookedRooms = AppBloc.get(context).bookedRooms;
          return Container(
            width: width * 0.6,
            height: height * 0.4,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookedRooms.length,
              itemBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Room type: ${bookedRooms[index].roomType}",
                        style: response14font),
                    Text("Room Cost: ${bookedRooms[index].cost}",
                        style: response14font),
                    Text("Guest:", style: response16font),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * 0.2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bookedRooms[index].guests.length,
                        itemBuilder: (context, inx) => Text(
                            bookedRooms[index].guests[inx],
                            style: response14font), //
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
