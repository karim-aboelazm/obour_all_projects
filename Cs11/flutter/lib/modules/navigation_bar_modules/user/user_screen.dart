import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/modules/%20login_and_signup/sign_in_and_sign_up_cubit.dart';
import 'package:kemet/modules/widgets/user_screen_widgets.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInAndSignUpCubit,SignInAndSignUpState>(
      listener: (context , state){},
      builder: (context , state){
        var myBloc = BlocProvider.of<SignInAndSignUpCubit>(context);
        return Scaffold(
          body: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              headerOfProfile(context),
              bodyOfProfile(context,(){},myBloc.userModel!.name.toString()),
              profilePicture(context),
              changeProfilePictureIcon(context,(){print('object');}),
            ],
          ),
        );
      },
    );
  }
}
