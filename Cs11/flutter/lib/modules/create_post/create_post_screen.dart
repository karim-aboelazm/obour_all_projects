import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/modules/create_post/create_post_cubit.dart';
import 'package:kemet/modules/widgets/post_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../ login_and_signup/sign_in_and_sign_up_cubit.dart';
import '../../core/strings.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreatePostCubit, CreatePostState>(
        listener: (context, state) {},
        builder: (context, state) {
          var myCubit = BlocProvider.of<CreatePostCubit>(context);
          if (state is PostPublishSuccess) {
            myCubit.resetContent(context);
          }
          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.primary,
                          size: 45,
                        ),
                        onPressed: () {
                          myCubit.resetContent(context);
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          myCubit.postPost(context);

                          //TODO:post the post.
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: Text(
                          AppStringsInEnglish.share,
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppStringsInEnglish.tellUsYourStory,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          BlocConsumer<SignInAndSignUpCubit,
                              SignInAndSignUpState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return postHeader(
                                BlocProvider.of<SignInAndSignUpCubit>(context)
                                    .userModel!
                                    .username,
                                DateTime.now().toString(),
                              );
                            },
                          ),
                          ...myCubit.contentWidgetsList
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Color(0x33000000),
                        offset: Offset(0, -2),
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: InkWell(
                          onTap: () {
                            myCubit.addImage(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.image,
                                color: AppColors.primary,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(AppStringsInEnglish.addPicture),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: InkWell(
                          onTap: () {
                            myCubit.addPlace(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: AppColors.primary,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(AppStringsInEnglish.addPlace),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
