part of 'favorites_cubit.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class GetFavoritPlacesLoading extends FavoritesState {}

class GetFavoritPlacesSuccess extends FavoritesState {}

class GetFavoritPlacesError extends FavoritesState {}
