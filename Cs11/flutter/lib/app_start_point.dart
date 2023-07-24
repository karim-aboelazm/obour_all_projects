import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/core/themes.dart';
import 'package:kemet/modules/%20login_and_signup/sign_in_and_sign_up_cubit.dart';
import 'package:kemet/modules/%20login_and_signup/sign_in_and_sign_up_screen.dart';
import 'package:kemet/modules/create_post/create_post_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignInAndSignUpCubit()),
        BlocProvider(
            create: (context) => CreatePostCubit()
              ..addText(context, hint: AppStringsInEnglish.addPostLable)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStringsInEnglish.appName,
        theme: appLightTheme(),
        darkTheme: appDarkTheme(),
        //TODO:Handle the start point
        home: const SignPage(),
      ),
    );
  }
}










// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   @override
//   void initState() {
//     super.initState();
//     initialization();
//   }
//
//   void initialization() async {
//     //TODO: If we wanna reload data before finish Splash
//     FlutterNativeSplash.remove();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         title:const Text(
//           'Home Screen'
//         ),
//       ) ,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.red,
//         child: Image.asset('assets/images/kemet.png'),
//       ),
//     );
//   }
// }
//
