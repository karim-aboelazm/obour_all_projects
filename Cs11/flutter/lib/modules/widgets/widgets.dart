import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/models/place_hint.dart';

import '../../helper/end_points.dart';

Widget defaultTextFormField({
  initValue,
  required validator,
  required textInputType,
  required isPassword,
  Function? function,
  required controller,
  required label,
  labelColor,
  required bool arabic,
  hintText,
  icon,
  iconColor,
  maxLines = 1,
  Widget? iconWidget,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      borderRadius: BorderRadius.circular(
        5.0,
      ),
      border: Border.all(color: AppColors.black, width: 0.1),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 1, 5, 1),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              obscureText: isPassword,
              keyboardType: textInputType,
              initialValue: initValue,
              validator: validator,
              maxLines: maxLines,
              minLines: 1,
              onFieldSubmitted: (value) {
                function == null ? null : function(value);
              },
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Row(
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        color: iconColor,
                      ),
                    Text(
                      label,
                      style: TextStyle(
                          color: labelColor == null
                              ? AppColors.black
                              : labelColor),
                    ),
                  ],
                ),
                hintText: hintText,
              ),
            ),
          ),
          iconWidget ?? const SizedBox(),
        ],
      ),
    ),
  );
}

Widget commentTextFormField({
  initValue,
  required validator,
  required textInputType,
  required isPassword,
  Function? function,
  required controller,
  required label,
  labelColor,
  required bool arabic,
  hintText,
  icon,
  iconColor,
  maxLines = 1,
  Widget? iconWidget,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      borderRadius: BorderRadius.circular(
        5.0,
      ),
      border: Border.all(color: AppColors.black, width: 0.1),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 1, 5, 1),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              obscureText: isPassword,
              keyboardType: textInputType,
              initialValue: initValue,
              validator: validator,
              maxLines: maxLines,
              minLines: 1,
              onFieldSubmitted: (value) {
                function == null ? null : function(value);
              },
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Row(
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        color: iconColor,
                      ),
                    Text(
                      label,
                      style: TextStyle(
                          color: labelColor == null
                              ? AppColors.black
                              : labelColor),
                    ),
                  ],
                ),
                hintText: hintText,
              ),
            ),
          ),
          iconWidget ?? const SizedBox(),
        ],
      ),
    ),
  );
}

Widget defaultButton({
  Widget? img,
  double? width,
  double? height,
  double r = 10.0,
  required String text,
  required Color color,
  Color txtColor = Colors.white,
  required function,
  required context,
}) =>
    Container(
      height: height ?? 48,
      width: width == null ? MediaQuery.of(context).size.width * 0.80 : width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            r,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: TextButton(
        onPressed: function,
        child: img == null
            ? Text(
                text,
                style: TextStyle(
                  color: txtColor,
                ),
              )
            : Row(
                children: [
                  const SizedBox(
                    width: 60,
                  ),
                  img,
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: txtColor,
                    ),
                  )
                ],
              ),
      ),
    );

Widget PlaceInContext(context, PlaceHint placeHint) {
  return Row(
    children: [
      Image.network(
        placeHint.image,
        width: MediaQueryValues(context).width / 6,
        height: MediaQueryValues(context).width / 6,
        fit: BoxFit.cover,
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(placeHint.name),
      ),
    ],
  );
}

class LikeButton extends StatefulWidget {
  Function onTap;
  int count;
  bool isLiked;
  LikeButton(
      {required this.onTap,
      required this.count,
      this.isLiked = false,
      super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState(onTap, count, isLiked);
}

class _LikeButtonState extends State<LikeButton> {
  Function onTap;
  int count;
  bool isLiked;
  _LikeButtonState(this.onTap, this.count, this.isLiked);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        //TODO: update the like button view.
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
              border: Border.all(
                color: AppColors.primary,
                width: 3,
              ),
            ),
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: AppColors.orange,
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

Widget commentsCounter(String count) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5),
            topLeft: Radius.circular(5),
          ),
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        child: Icon(
          //size: 15,
          Icons.mode_comment_outlined,
          color: AppColors.orange,
        ),
      ),
      Container(
        width: 25,
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Text(
          count,
          style: TextStyle(color: AppColors.white),
        ),
      ),
    ],
  );
}
