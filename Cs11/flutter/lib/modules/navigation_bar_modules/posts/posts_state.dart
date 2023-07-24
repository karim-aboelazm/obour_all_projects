part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class GetPostsLoading extends PostsState {}

class GetPostsSuccess extends PostsState {}

class GetPostsError extends PostsState {}

class GoingToCreatePostScreenSuccess extends PostsState {}
