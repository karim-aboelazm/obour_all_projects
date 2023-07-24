part of 'place_search_page_cubit.dart';

@immutable
abstract class PlaceSearchPageState {}

class PlaceSearchPageInitial extends PlaceSearchPageState {}

class GetPlacesSuccess extends PlaceSearchPageState {}

class GetPlacesLoading extends PlaceSearchPageState {}

class GetPlacesError extends PlaceSearchPageState {}

class UpdatePlacesSuccess extends PlaceSearchPageState {}
