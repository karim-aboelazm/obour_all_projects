import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context,required String text,required Color clr}) {
  final snackBar = SnackBar(
    duration:const Duration(seconds: 3),
    backgroundColor: clr,
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}