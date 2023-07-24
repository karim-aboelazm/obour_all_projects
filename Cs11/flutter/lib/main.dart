import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:kemet/app_start_point.dart';  
import 'package:kemet/helper/local/cache_helper.dart';  
import 'package:flutter_native_splash/flutter_native_splash.dart';  
import 'package:kemet/helper/remote/dio_helper.dart';   

import 'helper/bloc_observer.dart'; 

void main()async {  
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();  
  widgetsBinding;   
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await CacheHelper.init();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  
  
  
  runApp(const MyApp());



}


