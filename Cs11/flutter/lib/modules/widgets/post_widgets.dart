import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/helper/end_points.dart';
import 'package:kemet/helper/remote/dio_helper.dart';
import 'package:kemet/models/place_hint.dart';
import 'package:kemet/models/post_model.dart';
import 'package:kemet/modules/comments/comments_component.dart';
import 'package:kemet/modules/widgets/snackbar_widget.dart';
import 'package:kemet/models/place_model.dart';
import 'package:kemet/modules/widgets/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget addPostCard(BuildContext context, Function onTap) {
  TextEditingController controller = TextEditingController();
  return InkWell(
    onTap: () {
      onTap(context);
    },
    child: DottedBorder(
      color: AppColors.primary,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/account_avatar.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                child: TextFormField(
                  enabled: false,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: AppStringsInEnglish.addPostLable,
                    hintText: AppStringsInEnglish.addPostLable,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary, // Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        AppStringsInEnglish.share,
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),
                  onTap: () {
                    onTap(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget postImage(context, image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        "${AppEndPoints.baseUrl}${image}",
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        height: 300,
      ),
    ),
  );
}

Widget postPlaceCard(BuildContext context, PlaceHint place, comment) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: MediaQueryValues(context).width - 40,
          child: Column(
            children: [
              PlaceInContext(context, place), //k
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(comment ?? ""),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget post(BuildContext context, Post post) {
  return Padding(
    padding: EdgeInsets.only(top: 10),
    child: Container(
      width: double.infinity,
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          postHeader(post.userName, post.postedAt),
          ...postBody(context, post.content),
          PostFooter(
            postId: post.id,
            commentsCount: post.commentsCount,
          ),
        ],
      ),
    ),
  );
}

getPlace(context, placeId) async {
  return await DioHelper.getData(url: AppEndPoints.getPlace(placeId))
      .catchError((e) {
    showSnackBar(context: context, text: e.toString(), clr: AppColors.error);
  });
}

List<Widget> postBody(context, List body) {
  List<Widget> bodyWidgets = [];
  for (int i = 0; i < body.length; i++) {
    if (body[i].type == 'text') {
      bodyWidgets.add(
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(body[i].text),
            ],
          ),
        ),
      );
    } else if (body[i].type == 'place') {
      //var place = getPlace(context, body[i]['id']);
      //print("Place:.....${place}....");
      bodyWidgets.add(postPlaceCard(
        context,
        PlaceHint(
            id: body[i].placeHint.id,
            name: body[i].placeHint.name,
            image: body[i].placeHint.image),
        body[i].comment,
      ));
    } else if (body[i].type == 'image') {
      bodyWidgets.add(postImage(context, body[i].image));
    }
  }
  return bodyWidgets;
}

Widget postHeader(String userName, String postedAt) {
  String postedSince = timeago.format(DateTime.parse(postedAt));

  return Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          'assets/images/account_avatar.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(userName),
              //TODO: build the expanded icon button for 'the list of post actions'
            ],
          ),
          Text(
            postedSince,
            style: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Color(0xFF95A1AC),
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      )
    ],
  );
}

class PostFooter extends StatefulWidget {
  final int postId;
  final String commentsCount;
  const PostFooter(
      {required this.postId, required this.commentsCount, super.key});

  @override
  State<PostFooter> createState() => _PostFooterState(postId, commentsCount);
}

class _PostFooterState extends State<PostFooter> {
  bool showComments = false;
  final int postId;
  String commentsCount;
  _PostFooterState(this.postId, this.commentsCount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      //TODO:write the share script
                    },
                    icon: Icon(
                      Icons.share_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  //TODO: add like button
                  commentsCounter(commentsCount),
                ],
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    showComments = !showComments;
                  });
                },
                child: Text(
                  showComments
                      ? AppStringsInEnglish.hideComments
                      : AppStringsInEnglish.showComments,
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        showComments
            ? CommentSection(
                parentId: postId,
                parentType: 'post',
                width: MediaQueryValues(context).width,
              )
            : const SizedBox(),
      ],
    );
  }
}
