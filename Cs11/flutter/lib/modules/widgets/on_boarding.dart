import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/strings.dart';

Widget searchField ({required context,required textEditingController}){
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color:AppColors.black)
      ),
      width: MediaQueryValues(context).width*3/4,
      child: TextFormField(
        controller: textEditingController,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          icon: Padding(
            padding:const EdgeInsets.all(15.0),
            child: Icon(Icons.search,color: AppColors.black,),
          ),
          hintText: AppStringsInEnglish.search,
          border: InputBorder.none
        ),
      ),
    ),
  );
}