import 'package:carezone/ui/medicine_reminder/global_bloc.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'pages/home_page.dart';

class MainReminderScreen extends StatefulWidget {
  const MainReminderScreen({super.key});

  @override
  State<MainReminderScreen> createState() => _MainReminderScreen();
}

class _MainReminderScreen extends State<MainReminderScreen> {
  // This widget is the root of your application.
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      child: Sizer(builder: (context, orientation, deviceType) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pill Reminder',
            //theme customization
            home: HomeReminder());
      }),
    );
  }
}
