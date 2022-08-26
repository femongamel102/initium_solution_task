import 'package:initium_project/ui/models/room_type.dart';

RoomType roomType = RoomType();
//let suggesting we have 4 branches / locations
const branchesData = ["Dahab", "Assyut", "Cairo", "Suhaj", "Alex"];
// and let every branch have 6 rooms
List roomsData = [
  {
    "branch": "",
    "room_number": 1,
    "booked": false,
    "type": "${roomType.singleRoom.toString()}",
    "guest": "",
    "cost": 300,
    "bookfrom": "",
    "bookto": ""
  },
  {
    "branch": "",
    "room_number": 2,
    "booked": false,
    "type": "${roomType.singleRoom.toString()}",
    "guest": "",
    "cost": 300,
    "bookfrom": "",
    "bookto": ""
  },
  {
    "branch": "",
    "room_number": 3,
    "booked": false,
    "type": "${roomType.doubleRoom.toString()}",
    "guest": "",
    "cost": 500,
    "bookfrom": "",
    "bookto": ""
  },
  {
    "branch": "",
    "room_number": 4,
    "booked": false,
    "type": "${roomType.doubleRoom.toString()}",
    "guest": "",
    "cost": 500,
    "bookfrom": "",
    "bookto": ""
  },
  {
    "branch": "",
    "room_number": 5,
    "booked": false,
    "type": "${roomType.suitRoom.toString()}",
    "guest": "",
    "cost": 700,
    "bookfrom": "",
    "bookto": ""
  },
  {
    "branch": "",
    "room_number": 6,
    "booked": false,
    "type": "${roomType.suitRoom.toString()}",
    "guest": "",
    "cost": 700,
    "bookfrom": "",
    "bookto": ""
  },
  {
    "branch": "",
    "room_number": 7,
    "booked": false,
    "type": "${roomType.fourthRoom.toString()}",
    "guest": "",
    "cost": 700,
    "bookfrom": "",
    "bookto": ""
  },
  {
    "branch": "",
    "room_number": 8,
    "booked": false,
    "type": "${roomType.fourthRoom.toString()}",
    "guest": "",
    "cost": 700,
    "bookfrom": "",
    "bookto": ""
  },
];

List roomtypeList = ["single", "double", "suit", "fourth"];
