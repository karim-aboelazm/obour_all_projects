import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/core/constants.dart';
import 'package:kemet/modules/%20login_and_signup/sign_in_and_sign_up_cubit.dart';
import 'package:kemet/modules/widgets/sign_page_widgets.dart';

import 'package:kemet/modules/widgets/widgets.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    //TODO: If we wanna reload data before finish Splash
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInAndSignUpCubit, SignInAndSignUpState>(
      listener: (context, state) {},
      builder: (context, state) {
        var myBloc = BlocProvider.of<SignInAndSignUpCubit>(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/kemet.png'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 20,
                    ),
                    loginSelected
                        ? //start part one
                        Container(
                            height: MediaQuery.of(context).size.height * 1 / 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(23),
                                topRight: Radius.circular(23),
                                bottomRight: Radius.circular(23),
                                bottomLeft: Radius.circular(0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                selectedLoginButton(context),
                                Expanded(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            loginSelected = false;
                                          });
                                        },
                                        child: Text(
                                          AppStringsInEnglish.signup,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )

                        // start part two
                        : Container(
                            height: MediaQuery.of(context).size.height * 1 / 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(23),
                                topRight: Radius.circular(23),
                                bottomRight: Radius.circular(23),
                                bottomLeft: Radius.circular(23),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            loginSelected = true;
                                          });
                                        },
                                        child: Text(
                                          AppStringsInEnglish.login,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                selectedSignupButton(context)
                              ],
                            ),
                          ),
                    AnimatedCrossFade(
                      secondChild: signupForms(
                        usernameController: myBloc.usernameSignupController,
                        emailController: myBloc.emailSignupController,
                        passwordController: myBloc.passwordSignupController,
                        phoneController: myBloc.phoneSignupController,
                        context: context,
                      ),
                      firstChild: loginForms(
                        emailController: myBloc.emailLoginController,
                        passwordController: myBloc.passwordLoginController,
                        context: context,
                      ),
                      crossFadeState: loginSelected
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 500),
                    ),
                    if (loginSelected)
                      state is LoginLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : defaultButton(
                              text: AppStringsInEnglish.login,
                              // login logic
                              // TODO : Handle Shared Prefernce
                              function: () {
                                myBloc.getToken(
                                  context,
                                  myBloc.emailLoginController.text.trim(),
                                  myBloc.passwordLoginController.text.trim(),
                                  false
                                );
                                myBloc.login(context);
                              },
                              context: context,
                              color: AppColors.primary,
                            )
                    else
                      state is SignupWithEmailLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : defaultButton(
                              text: AppStringsInEnglish.signup,
                              // signup logic
                              // TODO : Handle Shared Prefernce
                              function: () {
                                myBloc.signUp(context);

                              },
                              context: context,
                              color: AppColors.primary,
                            ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                      child: defaultButton(
                        img: Image.asset('assets/images/google.png'),
                        txtColor: AppColors.black,
                        color: AppColors.white,
                        text: AppStringsInEnglish.google,
                        //TODO: google signup
                        function: () {},
                        context: context,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: defaultButton(
                        img: Image.asset('assets/images/facebook.png'),
                        color: AppColors.facebookButton,
                        txtColor: AppColors.white,
                        text: AppStringsInEnglish.facebook,
                        //TODO: facebook signup
                        function: () {
                          myBloc.testGoToNavigationBar(context);
                        },
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
