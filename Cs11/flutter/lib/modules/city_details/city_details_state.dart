part of 'city_details_cubit.dart';

@immutable
abstract class CityDetailsState {}

class CityDetailsInitial extends CityDetailsState {}

class GetPlacesLoading extends CityDetailsState {}

class GetPlacesSuccess extends CityDetailsState {}

class GetPlacesError extends CityDetailsState {}
