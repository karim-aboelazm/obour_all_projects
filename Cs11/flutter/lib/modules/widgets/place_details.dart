import 'package:flutter/material.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/helper/end_points.dart';

import '../../core/colors.dart';
import '../../core/media_query_values.dart';

Widget detailedScreenDraft(
  context, {
  required String title,
  double imageHeight = 200,
  String imageLink = '${AppEndPoints.baseUrl}/media/places/kemet.png',
  Widget? headCardItem,
  required List<Widget> children,
}) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Image.network(
              imageLink,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Column(children: [
            SizedBox(height: imageHeight),
            Container(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height * 1) - imageHeight,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 245, 245, 245),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...children,
                    ],
                  ),
                ),
              ),
            ),
          ]),
          Column(
            children: [
              SizedBox(
                height: imageHeight - 35,
                width: MediaQueryValues(context).width,
              ),
              Container(
                width: MediaQueryValues(context).width * 0.7,
                height: MediaQueryValues(context).height * 0.095,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.black,
                      offset: const Offset(0, 1),
                      spreadRadius: 0.5,
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 10, 5, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            headCardItem ?? const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(5, 5, 15, 5),
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        minRadius: 15,
                        child: Icon(Icons.favorite,
                            size: 25, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        color: Colors.transparent,
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFFC58F26),
                          size: 45,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget headNote(context, {required String text, IconData? icon}) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 0, 5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 35,
            decoration: const BoxDecoration(
              color: Color(0xFFE4A325),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(30),
                topRight: Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  icon != null
                      ? Icon(
                          icon,
                          color: Colors.white,
                          size: 24,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
