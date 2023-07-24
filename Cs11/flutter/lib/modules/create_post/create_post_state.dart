part of 'create_post_cubit.dart';

@immutable
abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class PlaceUpdated extends CreatePostState {}

class PlaceAdded extends CreatePostState {}

class ContentReset extends CreatePostState {}

class ImageAdded extends CreatePostState {}

class PostPublishSuccess extends CreatePostState {}

class PostPublishLoading extends CreatePostState {}

class PostPublishError extends CreatePostState {}
