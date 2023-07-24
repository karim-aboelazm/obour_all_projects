import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/modules/widgets/post_widgets.dart';
import 'package:kemet/modules/widgets/widgets.dart';

import '../../../helper/shimmer/post_shimmer.dart';
import '../navigation_bar_modules/user/user_screen_cubit.dart';

Widget iconChips() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(110),
        color: AppColors.blackWithOpacity,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.safety_check,
              color: AppColors.primary,
            ),
            Text(
              '122',
              style: TextStyle(color: AppColors.white),
            )
          ],
        ),
      ),
    ),
  );
}

Widget userInformation(context, editFunc,name) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
          ),
          SizedBox(
            width: MediaQueryValues(context).width * 3 / 90,
          ),
          InkWell(
            onTap: editFunc,
            child: Icon(
              Icons.edit,
              color: AppColors.hint,
            ),
          )
        ],
      ),
      SizedBox(
        height: MediaQueryValues(context).height * 2 / 250,
      ),
      Text(
        AppStringsInEnglish.userLocation,
        style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconChips(),
          iconChips(),
        ],
      ),
      /*Row(
        children: [
          defaultButton(
              text: 'Recent Trips',
              color: AppColors.primary,
              function: () {},
              context: context,
              width: 0),
          defaultButton(
              text: 'Recent Trips',
              color: AppColors.primary,
              function: () {},
              context: context,
              width: 0),
        ],
      ),*/
    ],
  );
}

Widget headerOfProfile(context) {
  return SizedBox(
    height: MediaQueryValues(context).height * 1 / 3,
    width: double.infinity,
    child: Image.asset(
      'assets/images/stack.png',
      fit: BoxFit.fitWidth,
    ),
  );
}

Widget changeProfilePictureIcon(context, func) {
  return Positioned(
    bottom: MediaQueryValues(context).height * 7 / 10.5,
    right: MediaQueryValues(context).width * 7 / 18,
    child: CircleAvatar(
      maxRadius: MediaQueryValues(context).height * 5 / 300,
      backgroundColor: AppColors.primary,
      child: InkWell(
        onTap: func,
        child: Icon(
          Icons.add,
          color: AppColors.black,
        ),
      ),
      //assets/images/test.png
    ),
  );
}

Widget profilePicture(context) {
  return Positioned(
    bottom: MediaQueryValues(context).height * 7 / 10.5,
    child: CircleAvatar(
      maxRadius: MediaQueryValues(context).height * 5 / 70,
      backgroundColor: AppColors.white,
      child: Image.asset('assets/images/account_avatar.png'),
      //assets/images/test.png
    ),
  );
}

Widget bodyOfProfile(context, editFunc,name) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      height: MediaQueryValues(context).height * 5 / 7,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQueryValues(context).height * 2 / 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              userInformation(context, editFunc,name),
              BlocProvider(
                create: (context) => UserScreenCubit()..getPosts(context),
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Container(
                    color: AppColors.grey,
                    child: BlocConsumer<UserScreenCubit, UserScreenState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var myBlok = BlocProvider.of<UserScreenCubit>(context);
                        if (state is GetPostsLoading) {
                          return Column(
                            children: const [
                              PostShimmer(),
                              PostShimmer(),
                            ],
                          );
                        }
                        if (state is GetPostsSuccess) {
                          return Column(
                            children: [
                              for (int i = 0; i < myBlok.postsList.length; i++)
                                post(
                                  context,
                                  myBlok.postsList[i],
                                ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          );
                        }
                        return Text(AppStringsInEnglish.oops);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
