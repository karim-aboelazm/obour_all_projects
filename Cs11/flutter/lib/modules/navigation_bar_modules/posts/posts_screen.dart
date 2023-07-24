import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/helper/shimmer/post_shimmer.dart';
import 'package:kemet/modules/navigation_bar_modules/posts/posts_cubit.dart';
import 'package:kemet/modules/widgets/home_screen_widgets.dart';
import 'package:kemet/modules/widgets/post_widgets.dart';


class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PostsCubit()..getPosts(context),
        child: Padding(
          padding: EdgeInsets.only(top: 35),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      welcomeWidget(context),
                      BlocBuilder<PostsCubit, PostsState>(
                        builder: (context, state) {
                          var myBlok = BlocProvider.of<PostsCubit>(context);
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 15, bottom: 15, left: 10, right: 10),
                            child: addPostCard(context, myBlok.goToCtreatePost),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  color: AppColors.grey,
                  child: BlocConsumer<PostsCubit, PostsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var myBlok = BlocProvider.of<PostsCubit>(context);
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
                              height: 200,
                            ),
                          ],
                        );
                      }
                      return Text(AppStringsInEnglish.oops);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
