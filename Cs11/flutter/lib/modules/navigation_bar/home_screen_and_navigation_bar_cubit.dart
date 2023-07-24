import 'package:bloc/bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/modules/navigation_bar_modules/favorites/favorites_screen.dart';
import 'package:kemet/modules/navigation_bar_modules/home/home_screen.dart';
import 'package:kemet/modules/navigation_bar_modules/posts/posts_screen.dart';
import 'package:kemet/modules/navigation_bar_modules/travel_assistant/travel_assistant_screen.dart';
import 'package:kemet/modules/navigation_bar_modules/user/user_screen.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'home_screen_and_navigation_bar_state.dart';

class HomeScreenAndNavigationBarCubit
    extends Cubit<HomeScreenAndNavigationBarState> {
  HomeScreenAndNavigationBarCubit()
      : super(HomeScreenAndNavigationBarInitial());

  int currentIndex = 0;
  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  );
  EdgeInsets padding = const EdgeInsets.all(30);
  SnakeShape mySnakeShape = SnakeShape.circle;

  // TODO : Handle Icons
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark_added_outlined),
      label: 'favorites',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        'assets/images/ai_icon.png',
        color: Colors.white,
      ),
      label: 'Travel Assistant',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.comment),
      label: 'posts',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'user',
    )
  ];

  List screensOfNavBar = const [
    HomeScreen(),
    FavoritesScreen(),
    TravelAssistantView(),
    PostsScreen(),
    UserScreen(),
  ];

  void changeBottomNavigationBarIndex(newIndex,context) {
    emit(HomeScreenAndNavigationBarCurrentIndex());
    if(newIndex==2){
      // currentIndex = 0;
      navigateTo(context, const TravelAssistantView());
    }
    if(newIndex!=2){
      currentIndex = newIndex;
    }

    emit(HomeScreenAndNavigationBarMovingIndex());
  }
}
