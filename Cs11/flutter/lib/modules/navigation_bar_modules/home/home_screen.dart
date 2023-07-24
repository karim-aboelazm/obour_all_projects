import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/helper/shimmer/card_shimmer.dart';
import 'package:kemet/helper/shimmer/category_shimmer.dart';
import 'package:kemet/modules/navigation_bar_modules/home/home_screen_cubit.dart';
import 'package:kemet/modules/widgets/home_screen_widgets.dart';
import 'package:kemet/modules/widgets/widgets.dart';
import '../../../core/navigation.dart';
import '../../../models/place_hint.dart';
import '../../../models/place_model.dart';
import '../../create_post/create_post_cubit.dart';
import '../../place_details/place_details_screen.dart';
import '../../place_search_page/place_search_page_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return BlocProvider(
      create: (context) => HomeScreenCubit()
        ..getCategory(context: context)
        ..getPlaces(context: context)
        ..getCities(context: context),
      child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var myBloc = BlocProvider.of<HomeScreenCubit>(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      welcomeWidget(context),
                      textWidget(context, AppStringsInArabic.whereWillYouGo,
                          25.0, AppColors.black),
                      // defaultTextFormField(
                      //   arabic: true,
                      //   validator: (value) {
                      //     myBloc.validateSearchResult(value);
                      //   },
                      //   controller: myBloc.searchController,
                      //   label: AppStringsInArabic.search,
                      //   labelColor: AppColors.hint,
                      //   icon: Icons.search,
                      //   iconColor: AppColors.hint,
                      //   textInputType: TextInputType.text,
                      //   isPassword: false,
                      // ),
                      BlocProvider(
                        create: (context) => PlaceSearchPageCubit(),
                        child: BlocConsumer<PlaceSearchPageCubit,
                            PlaceSearchPageState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            var myCubit =
                                BlocProvider.of<PlaceSearchPageCubit>(context);
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  child: TextFormField(
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      hintText: AppStringsInArabic.search,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors
                                              .primary, // Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors
                                              .primary, // Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              15, 15, 15, 15),
                                      prefixIcon: Icon(Icons.search_rounded),
                                    ),
                                    onChanged: (value) {
                                      if (_controller.text.isNotEmpty) {
                                        myCubit.getSearchResuls(
                                            context, _controller.text);
                                      }
                                    },
                                  ),
                                ),
                                for (int i = 0;
                                    i < myCubit.searchResults.length;
                                    i++) ...[
                                  BlocBuilder<PlaceSearchPageCubit,
                                      PlaceSearchPageState>(
                                    builder: (context, state) {
                                      return InkWell(
                                        onTap: () async {
                                          myCubit.navigateById(context, i);
                                        },
                                        child:
                                            Text(myCubit.searchResults[i].name),
                                      );
                                    },
                                  ),
                                  const Divider(),
                                ]
                              ],
                            );
                          },
                        ),
                      ),

                      ///TODO : Categories
                      textWidget(
                        context,
                        AppStringsInArabic.categories,
                        18.0,
                        AppColors.black,
                      ),

                      ConditionalBuilder(
                        condition: state is GetCategoryLoading,
                        builder: (context) => SizedBox(
                          height: 50,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, item) =>
                                  const CategoryShimmer(),
                            ),
                          ),
                        ),
                        fallback: (context) => SizedBox(
                          height: 50,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: myBloc.categories.length,
                              itemBuilder: (context, item) => categoryWidget(
                                  context, myBloc.categories[item]),
                            ),
                          ),
                        ),
                      ),

                      /// TODO : Popular
                      textWidget(context, AppStringsInArabic.popularPlaces,
                          18.0, AppColors.black),
                      ConditionalBuilder(
                        condition: state is GetPlacesHomeLoading,
                        builder: (context) => GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent:
                                MediaQueryValues(context).height * 1 / 4,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing:
                                MediaQueryValues(context).width * 1 / 30,
                          ),
                          itemBuilder: (context, item) {
                            return const CardShimmer();
                          },
                        ),
                        fallback: (context) => GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: myBloc.placesList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent:
                                MediaQueryValues(context).height * 1 / 4,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing:
                                MediaQueryValues(context).width * 1 / 30,
                          ),
                          itemBuilder: (context, item) {
                            return cardOfPlace(
                                context, myBloc.placesList[item]);
                          },
                        ),
                      ),

                      ///TODO : Egypt
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              myBloc.goToEgyptGovernorates(context);
                            },
                            child: textWidget(
                              context,
                              AppStringsInArabic.showMore,
                              18.0,
                              AppColors.primary,
                            ),
                          ),
                          const Spacer(),
                          textWidget(
                              context,
                              AppStringsInArabic.egyptGovernorates,
                              18.0,
                              AppColors.black),
                        ],
                      ),
                      ConditionalBuilder(
                        condition: state is GetCitiesLoading,
                        builder: (context) => GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent:
                                MediaQueryValues(context).height * 1 / 4,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing:
                                MediaQueryValues(context).width * 1 / 30,
                          ),
                          itemBuilder: (context, item) {
                            return const CardShimmer();
                          },
                        ),
                        fallback: (context) => GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: myBloc.citiesList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent:
                                MediaQueryValues(context).height * 1 / 4,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing:
                                MediaQueryValues(context).width * 1 / 30,
                          ),
                          itemBuilder: (context, item) {
                            return cardOfGov(context, myBloc.citiesList[item]);
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQueryValues(context).height * 1 / 8,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
