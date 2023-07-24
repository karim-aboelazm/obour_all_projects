part of 'comments_cubit.dart';

@immutable
abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class GetCommentsLoading extends CommentsState {}

class GetCommentsSuccess extends CommentsState {}

class GetCommentsError extends CommentsState {}

class PostCommentsLoading extends CommentsState {}

class PostCommentsSuccess extends CommentsState {}

class PostCommentsError extends CommentsState {}
