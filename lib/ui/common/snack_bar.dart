import 'package:flutter/material.dart';
import 'package:initium_project/shared/style.dart';

customSnackBar (context,text){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
      Text(text, style: response14font),
    ),
  );
}