import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../helper/end_points.dart';
import '../../helper/remote/dio_helper.dart';
import '../../models/place_model.dart';
import '../widgets/snackbar_widget.dart';

part './city_details_state.dart';

class CityDetailsCubit extends Cubit<CityDetailsState> {
  CityDetailsCubit() : super(CityDetailsInitial());

  List<Place> placesList = [];

  void getPlaces({required BuildContext context, required cityId}) async {
    emit(GetPlacesLoading());

    await DioHelper.getData(
      url: AppEndPoints.getPlaceByCityId(cityId),
    ).then((value) {
      value.data.forEach((e) {
        placesList.add(Place.fromJson(e));
      });
      emit(GetPlacesSuccess());
    }).catchError((err) {
      showSnackBar(
          context: context, text: 'Error in get Places', clr: Colors.red);
      emit(GetPlacesError());
    });
  }
}
