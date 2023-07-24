import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';

Widget otpWidget(context) {
  return Form(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(9)),
          height: 60,
          width: 53,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.primary))),
            cursorColor: AppColors.primary,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        SizedBox(
          width: MediaQueryValues(context).width * 2 / 110,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(9)),
          height: 60,
          width: 53,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.primary))),
            cursorColor: AppColors.primary,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        SizedBox(
          width: MediaQueryValues(context).width * 2 / 110,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(9)),
          height: 60,
          width: 53,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.primary))),
            cursorColor: AppColors.primary,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        SizedBox(
          width: MediaQueryValues(context).width * 2 / 110,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(9)),
          height: 60,
          width: 53,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                //TODO: Logic if you fill the four fields
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.primary))),
            cursorColor: AppColors.primary,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    ),
  );
}
