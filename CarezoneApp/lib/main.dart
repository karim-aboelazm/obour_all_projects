import 'package:carezone/ui/auth/authscreen.dart';
import 'package:carezone/ui/main/main._view.dart';
import 'package:carezone/ui/resourses/routes_manager.dart';
import 'package:carezone/ui/resourses/theme_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: RouteGenerator.getRoute,
    theme: getApplicationTheme(),
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //check if there is auth users
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.data != null) {
          return const Mainpage();
        } else {
          return const Authscreen();
        }
      },
    );
  }
}
