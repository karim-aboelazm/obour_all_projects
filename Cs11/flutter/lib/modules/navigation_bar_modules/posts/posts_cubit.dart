import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/helper/end_points.dart';
import 'package:kemet/helper/remote/dio_helper.dart';
import 'package:kemet/models/post_model.dart';
import 'package:kemet/modules/create_post/create_post_screen.dart';
import 'package:kemet/modules/widgets/snackbar_widget.dart';
import 'package:meta/meta.dart';

import '../../../core/navigation.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  List<Post> postsList = [];

  void getPosts(context) {
    emit(GetPostsLoading());

    DioHelper.getData(
      url: AppEndPoints.getPosts,
    ).then((value) {
      value.data['results'].forEach((val) {
        postsList.add(Post.fromJson(val));
      });

      emit(GetPostsSuccess());
    }).catchError((err) {
      print(err.toString());
      emit(GetPostsError());
      showSnackBar(
          context: context,
          text: AppStringsInEnglish.getPostError,
          clr: AppColors.error);
    });
  }

  addPost(Post post) {
    postsList.add(post);
    emit(GetPostsSuccess());
  }

  void goToCtreatePost(context) {
    navigateTo(context, const CreatePost());
    //emit(GoingToCreatePostScreenSuccess());
  }
}
