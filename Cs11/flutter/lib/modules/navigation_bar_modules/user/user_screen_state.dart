part of 'user_screen_cubit.dart';

@immutable
abstract class UserScreenState {}

class UserScreenInitial extends UserScreenState {}

class GetPostsLoading extends UserScreenState {}

class GetPostsSuccess extends UserScreenState {}

class GetPostsError extends UserScreenState {}
