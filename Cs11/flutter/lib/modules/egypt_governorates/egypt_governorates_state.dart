part of 'egypt_governorates_cubit.dart';

@immutable
abstract class EgyptGovernoratesState {}

class EgyptGovernoratesInitial extends EgyptGovernoratesState {}

class GetCitiesLoading extends EgyptGovernoratesState {}

class GetCitiesSuccess extends EgyptGovernoratesState {}

class GetCitiesError extends EgyptGovernoratesState {}
