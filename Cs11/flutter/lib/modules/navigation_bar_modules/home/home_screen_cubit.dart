import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/helper/end_points.dart';
import 'package:kemet/helper/remote/dio_helper.dart';
import 'package:kemet/models/city.dart';
import 'package:kemet/models/place_category.dart';
import 'package:kemet/models/place_model.dart';
import 'package:kemet/modules/egypt_governorates/egypt_governorates_screen.dart';
import 'package:kemet/modules/widgets/snackbar_widget.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  List<PlaceCategory> categories = [];

  List<Place> placesList = [];

  List<City> citiesList = [];


  void getCategory({required BuildContext context}) async{
    emit(GetCategoryLoading());

    await DioHelper.getData(
      url: AppEndPoints.getCategory,
    ).then((value) {
      value.data['results'].forEach((e){
        categories.add(PlaceCategory.fromJson(e));
      });
       print(categories);
      emit(GetCategorySuccess());
    }).catchError((err) {
      print(err.toString());
      print(err.toString());
      showSnackBar(context: context, text: 'Error in get Category', clr: Colors.red);
      emit(GetCategoryError());
    });
  }

  void getPlaces({required BuildContext context}) async {
    emit(GetPlacesHomeLoading());

    await DioHelper.getData(
      url: AppEndPoints.getPlaces,
    ).then((value) {
      value.data['results'].forEach((e){
        placesList.add(Place.fromJson(e));
      });
      emit(GetPlacesSuccess());
    }).catchError((err) {
      print(err.toString());
      showSnackBar(context: context, text: 'Error in get Places', clr: Colors.red);
      emit(GetPlacesError());
    });
  }


  void getCities({required BuildContext context}) async {
    emit(GetCitiesLoading());

    await DioHelper.getData(
      url: AppEndPoints.getCities,
    ).then((value) {
      value.data['results'].forEach((e){
        citiesList.add(City.fromJson(e));
      });
      print(citiesList);
      emit(GetCitiesSuccess());
    }).catchError((err) {
      print(err.toString());
      showSnackBar(context: context, text: 'Error in get Cities', clr: Colors.red);
      emit(GetCitiesError());
    });
  }



  final searchController = TextEditingController();

  void validateSearchResult(value) {}

  void goToEgyptGovernorates(context) {
    navigateTo(context, const EgyptGovernoratesScreen());
    emit(GoingToEgyptGovernoratesScreenSuccess());
  }
}
