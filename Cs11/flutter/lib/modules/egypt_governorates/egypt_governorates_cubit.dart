import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kemet/helper/end_points.dart';
import 'package:kemet/helper/remote/dio_helper.dart';
import 'package:kemet/models/city.dart';
import 'package:kemet/modules/widgets/snackbar_widget.dart';

part 'egypt_governorates_state.dart';

class EgyptGovernoratesCubit extends Cubit<EgyptGovernoratesState> {
  EgyptGovernoratesCubit() : super(EgyptGovernoratesInitial());

  List<City> citiesList = [];
  String? next = null;
  String? previous = null;

  void getCities({required BuildContext context}) async {
    emit(GetCitiesLoading());

    await DioHelper.getData(
      url: AppEndPoints.getCities,
    ).then((value) {
      citiesList = [];
      value.data['results'].forEach((e) {
        citiesList.add(City.fromJson(e));
        next = value.data['next'];
        previous = value.data['previous'];
      });
      print(citiesList);
      emit(GetCitiesSuccess());
    }).catchError((err) {
      print(err.toString());
      showSnackBar(
          context: context, text: 'Error in get Cities', clr: Colors.red);
      emit(GetCitiesError());
    });
  }

  void goToNextPage({required BuildContext context}) async {
    emit(GetCitiesLoading());

    await DioHelper.getData(
      url: next!,
    ).then((value) {
      citiesList = [];
      value.data['results'].forEach((e) {
        citiesList.add(City.fromJson(e));
        next = value.data['next'];
        previous = value.data['previous'];
      });
      print(citiesList);
      emit(GetCitiesSuccess());
    }).catchError((err) {
      print(err.toString());
      showSnackBar(
          context: context, text: 'Error in get Cities', clr: Colors.red);
      emit(GetCitiesError());
    });
  }

  void goToPreviousPage({required BuildContext context}) async {
    emit(GetCitiesLoading());

    await DioHelper.getData(
      url: previous!,
    ).then((value) {
      value.data['results'].forEach((e) {
        citiesList.add(City.fromJson(e));
        next = value.data['next'];
        previous = value.data['previous'];
      });
      print(citiesList);
      emit(GetCitiesSuccess());
    }).catchError((err) {
      print(err.toString());
      showSnackBar(
          context: context, text: 'Error in get Cities', clr: Colors.red);
      emit(GetCitiesError());
    });
  }

  final searchController = TextEditingController();

  void validateSearchResult(value) {}
}
