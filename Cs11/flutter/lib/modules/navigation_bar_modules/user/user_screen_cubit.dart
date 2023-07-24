import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/colors.dart';
import '../../../core/strings.dart';
import '../../../helper/end_points.dart';
import '../../../helper/remote/dio_helper.dart';
import '../../../models/post_model.dart';
import '../../widgets/snackbar_widget.dart';

part 'user_screen_state.dart';

class UserScreenCubit extends Cubit<UserScreenState> {
  UserScreenCubit() : super(UserScreenInitial());

  List<Post> postsList = [];

  void getPosts(context) {
    emit(GetPostsLoading());

    DioHelper.getData(
      url: AppEndPoints.getPosts,
      query: {"user": "me"},
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
}
