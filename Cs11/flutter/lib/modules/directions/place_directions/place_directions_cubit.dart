import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part './place_directions_state.dart';

class PlaceDirectionsCubit extends Cubit<PlaceDirectionsState> {
  PlaceDirectionsCubit() : super(PlaceDirectionsInitial());
}
