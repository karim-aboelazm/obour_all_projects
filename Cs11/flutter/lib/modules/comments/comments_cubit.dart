import 'package:bloc/bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/helper/end_points.dart';
import 'package:kemet/helper/remote/dio_helper.dart';
import 'package:kemet/models/comment_model.dart';
import 'package:kemet/modules/widgets/snackbar_widget.dart';
import 'package:meta/meta.dart';

import '../../core/strings.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsInitial());

  List<Comment> commentsList = [];

  Map constructData(String text, String parentType, String parentId) {
    if (parentType == 'post') {
      return {
        "text": text,
        "place_id": "",
        "post_id": parentId,
        "comment_id": ""
      };
    }
    if (parentType == 'place') {
      return {
        "text": text,
        "place_id": parentId,
        "post_id": "",
        "comment_id": ""
      };
    }
    return {
      "text": text,
      "comment_id": parentId,
      "place_id": "",
      "post_id": ""
    };
  }

  void saveComment(context, text, parentType, parentId) {
    emit(PostCommentsLoading());
    DioHelper.postData(
      url: AppEndPoints.postComment,
      data: constructData(text, parentType, parentId.toString()),
    ).then((value) {
      showSnackBar(
        context: context,
        text: 'Comment Saved',
        clr: AppColors.green,
      );
      emit(PostCommentsSuccess());
    }).catchError((e) {
      print("error: ${e.toString()}");
      showSnackBar(
        context: context,
        text: 'Save Comment Error',
        clr: AppColors.error,
      );
      emit(PostCommentsError());
    });
  }

  void getComments(context, parentId, parentType) async {
    emit(GetCommentsLoading());

    await DioHelper.getData(
      url: AppEndPoints.getComments,
      query: {"parent_id": parentId, "parent_type": parentType},
    ).then((value) {
      commentsList = [];
      value.data.forEach((e) {
        commentsList.add(Comment.fromJson(e));
      });
      emit(GetCommentsSuccess());
    }).catchError((err) {
      print("error: ${err.toString()}");
      emit(GetCommentsError());
      showSnackBar(
          context: context,
          text: err.toString(), //AppStringsInEnglish.commentsError,
          clr: AppColors.error);
    });
  }
}
