import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';

import '../../core/media_query_values.dart';

Widget transportationCard(
    {required context,
    required String transportation,
    required int index,
    required Color color}) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      color: color,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x33000000),
              spreadRadius: 10,
              offset: Offset(0, 2),
            ),
          ]),
          width: MediaQueryValues(context).width - 40,
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Container(
                    color: color,
                    height: 20,
                    width: 20,
                    child: Padding(
                      padding: EdgeInsets.only(top: 4, left: 6),
                      child: Text(index.toString()),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(transportation)],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget transportationList(context, List transportations, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      transportationCard(
          context: context,
          transportation: transportations[0],
          index: 1,
          color: color),
      for (var i = 1; i < transportations.length; i++) ...[
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            width: 20,
            height: 30,
            color: color,
          ),
        ),
        transportationCard(
            context: context,
            transportation: transportations[i],
            index: i + 1,
            color: color),
      ]
    ],
  );
}
