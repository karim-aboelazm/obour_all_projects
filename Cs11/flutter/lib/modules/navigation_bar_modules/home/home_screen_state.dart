part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class GetCategoryLoading extends HomeScreenState {}
class GetCategorySuccess extends HomeScreenState {}
class GetCategoryError extends HomeScreenState {}

class GetPlacesHomeLoading extends HomeScreenState {}
class GetPlacesSuccess extends HomeScreenState {}
class GetPlacesError extends HomeScreenState {}

class GetCitiesLoading extends HomeScreenState {}
class GetCitiesSuccess extends HomeScreenState {}
class GetCitiesError extends HomeScreenState {}




















class GoingToEgyptGovernoratesScreenSuccess extends HomeScreenState {}
