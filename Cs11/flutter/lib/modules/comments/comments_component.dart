import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/modules/comments/comments_cubit.dart';

import '../../core/colors.dart';
import '../../core/strings.dart';
import '../../helper/shimmer/comment_shimmer.dart';
import '../../models/comment_model.dart';
import '../widgets/comment_widgets.dart';
import '../widgets/snackbar_widget.dart';
import '../widgets/widgets.dart';

class CommentSection extends StatelessWidget {
  final String parentType;
  final int parentId;
  final double width;
  const CommentSection(
      {required this.parentId,
      required this.parentType,
      required this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return AppStringsInEnglish.commentInputLable;
      }
      return null;
    }

    TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (context) =>
          CommentsCubit()..getComments(context, parentId, parentType),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: commentTextFormField(
              validator: validator,
              textInputType: TextInputType.multiline,
              isPassword: false,
              controller: controller,
              label: AppStringsInEnglish.commentInputLable,
              arabic: true,
              maxLines: 3,
              iconWidget: BlocConsumer<CommentsCubit, CommentsState>(
                listener: (context, state) {
                  if (state is PostCommentsSuccess) {
                    BlocProvider.of<CommentsCubit>(context).getComments(
                      context,
                      parentId,
                      parentType,
                    );
                  }
                },
                builder: (context, state) {
                  var myBloc = BlocProvider.of<CommentsCubit>(context);
                  return IconButton(
                    onPressed: () {
                      myBloc.saveComment(
                        context,
                        controller.text,
                        parentType,
                        parentId,
                      );
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
          ),
          BlocConsumer<CommentsCubit, CommentsState>(
            listener: (context, state) {},
            builder: (context, state) {
              var myBloc = BlocProvider.of<CommentsCubit>(context);
              if (state is GetCommentsLoading) {
                return ListView(
                  shrinkWrap: true,
                  children: const [
                    CommentShimmer(),
                    CommentShimmer(),
                  ],
                );
              } else if (state is GetCommentsSuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < myBloc.commentsList.length; i++)
                      CommentWidget(
                        comment: myBloc.commentsList[i],
                        width: width,
                      ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
