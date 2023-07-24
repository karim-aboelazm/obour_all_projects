import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/modules/comments/comments_component.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/comment_model.dart';

class CommentWidget extends StatefulWidget {
  Comment comment;
  double width;
  CommentWidget({required this.comment, required this.width, super.key});

  @override
  State<CommentWidget> createState() => _CommentWidgetState(comment, width);
}

class _CommentWidgetState extends State<CommentWidget> {
  final Comment comment;
  double width;
  _CommentWidgetState(this.comment, this.width);
  bool showReplays = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        commentHeader(comment.userName, comment.commentedAt),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Container(
            width: width,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: VerticalDivider(
                      thickness: 1.5,
                      color: AppColors.primary,
                    ),
                  ),
                  Column(
                    children: [
                      Text(comment.comment),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          comment.hasReplays
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      showReplays = !showReplays;
                                    });
                                  },
                                  child: Text(
                                    showReplays
                                        ? AppStringsInEnglish.hideReplaye
                                        : AppStringsInEnglish.showReplaye,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      showReplays
                          ?
                          //TODO:show the replays,
                          CommentSection(
                              parentId: comment.id,
                              parentType: "comment",
                              width: width - 20,
                            )
                          : const SizedBox()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

Widget commentHeader(String userName, commentedAt) {
  String commentedSince = timeago.format(DateTime.parse(commentedAt));
  //TODO: process commentedAt to get commentedSince
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
            commentedSince,
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
