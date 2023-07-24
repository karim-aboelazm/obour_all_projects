import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/modules/OTP/otp_cubit.dart';
import 'package:kemet/modules/on_boarding/on_boarding_screen.dart';
import 'package:kemet/modules/widgets/otp_widgets.dart';
import 'package:kemet/modules/widgets/widgets.dart';

//TODO:add single child scroll view.
class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {},
        builder: (context, state) {
          var myBloc = BlocProvider.of<OtpCubit>(context);
          return Scaffold(
            body: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQueryValues(context).height * 2 / 20,
                  ),
                  const Text(
                    AppStringsInEnglish.verifyEmail,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset(
                      'assets/images/verify.png',
                    ),
                  ),
                  const Text(
                    AppStringsInEnglish.verificationCodeSent,
                    style: TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: otpWidget(context),
                  ),
                  SizedBox(
                    height: MediaQueryValues(context).height * 2 / 20,
                  ),
                  defaultButton(
                    text: AppStringsInEnglish.verifyEmail,
                    color: AppColors.primary,
                    //TODO: Verify Logic
                    function: () {
                      navigateTo(context, OnBoardingScreen());
                    },
                    context: context,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
