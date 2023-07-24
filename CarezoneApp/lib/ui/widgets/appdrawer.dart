import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../resourses/Color_manager.dart';
import '../resourses/routes_manager.dart';
import '../resourses/styles_manager.dart';
import '../resourses/values_manager.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({super.key});

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      padding: const EdgeInsets.only(top: 70),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueGrey, Colors.blue],
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.home,
              size: AppSize.s32,
              color: ColorManager.white,
            ),
            title: Text(
              'Home',
              style: getRegularStyle(
                color: ColorManager.white,
                fontSize: AppSize.s18,
              ),
            ),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Routes.mainRoute),
          ),
          Divider(
            color: ColorManager.white,
            thickness: 0.8,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app_outlined,
              size: AppSize.s32,
              color: ColorManager.white,
            ),
            title: Text(
              'Sign Out',
              style: getRegularStyle(
                color: ColorManager.white,
                fontSize: AppSize.s18,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(Routes.login);
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    ));
  }
}
