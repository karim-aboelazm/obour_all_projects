import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part './directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  DirectionsCubit() : super(DirectionsInitial());
}
