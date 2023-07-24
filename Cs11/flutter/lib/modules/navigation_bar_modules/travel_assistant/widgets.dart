import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/modules/navigation_bar/home_screen_and_navigation_bar.dart';

Widget messageSender(message) {
  return Container(
    padding: const EdgeInsets.only(left: 100, right: 14, top: 10, bottom: 10),
    child: Align(
      alignment: (Alignment.topRight),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(0),
          ),
          color: AppColors.primary,
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    ),
  );
}

Widget messageReceiver(message) {
  return Container(
      padding: const EdgeInsets.only(left: 14, right: 100, top: 10, bottom: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(20),
            ),
            color: Colors.grey.shade200,
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            message,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ));
}

chatAppBar(context) {
  return AppBar(
    backgroundColor: AppColors.primary,
    leading: IconButton(
      onPressed: () {
        // myCubit.end();
        navigateToAndReplacement(
          context,
          const HomeScreenAndNavigationBar(),
        );
      },
      icon: const Icon(Icons.arrow_back_ios),
    ),
    title: Row(
      children: [
        Image.asset(
          'assets/images/ai_icon.png',
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 15,
        ),
        const Text(
          AppStringsInEnglish.bot,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
