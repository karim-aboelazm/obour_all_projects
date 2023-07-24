import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../helper/end_points.dart';
import '../../helper/remote/dio_helper.dart';
import '../widgets/snackbar_widget.dart';

part './place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  PlaceDetailsCubit() : super(PlaceDetailsInitial());

  void favPlace(context, placeId) async {
    emit(SetAsFavLoading());

    await DioHelper.postData(
      url: AppEndPoints.setFavPlace(placeId),
      data: {},
    ).then((value) {
      showSnackBar(
          context: context,
          text: 'Place is set as Favorite Successfully',
          clr: Colors.green);
      emit(SetAsFavSuccess());
    }).catchError((err) {
      showSnackBar(
          context: context,
          text: 'Error in set Place as Favorite',
          clr: Colors.red);
      emit(SetAsFavError());
    });
  }

  void unFavPlace(context, placeId) async {
    emit(SetAsFavLoading());

    DioHelper.deleteData(
      url: AppEndPoints.setFavPlace(placeId),
      data: {},
    ).then((value) {
      showSnackBar(
          context: context,
          text: 'Place is removed from Favorites Successfully',
          clr: Colors.green);
      emit(SetAsFavSuccess());
    }).catchError((err) {
      showSnackBar(
          context: context,
          text: 'Error in remove Place from Favorites',
          clr: Colors.red);
      emit(SetAsFavError());
    });
  }

  ratePlace(context, placeId, rate) async {
    emit(RatePlaceLoading());

    DioHelper.postData(
      url: AppEndPoints.ratePlace,
      data: {"place_id": placeId, "rate": "$rate"},
    ).then((value) {
      showSnackBar(
          context: context,
          text: 'Place rate is saved Successfully',
          clr: Colors.green);
      emit(RatePlaceSuccess());
    }).catchError((err) {
      print(err.toString());
      showSnackBar(
          context: context, text: 'Error in rate Place', clr: Colors.red);
      emit(RatePlaceError());
    });
  }
}
