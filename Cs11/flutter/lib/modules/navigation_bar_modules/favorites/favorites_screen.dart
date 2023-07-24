import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/helper/shimmer/card_shimmer.dart';
import 'package:kemet/modules/navigation_bar_modules/favorites/favorites_cubit.dart';
import 'package:kemet/modules/widgets/home_screen_widgets.dart';
import 'package:kemet/core/media_query_values.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => FavoritesCubit()..getPlaces(context: context),
          child: BlocConsumer<FavoritesCubit, FavoritesState>(
            listener: (context, state) {},
            builder: (context, state) {
              var myBloc = BlocProvider.of<FavoritesCubit>(context);

              if (state is GetFavoritPlacesError ||
                  (state is GetFavoritPlacesSuccess && myBloc.places.isEmpty)) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/images/favorites_empty.png'),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      welcomeWidget(context),
                      textWidget(
                          context,
                          AppStringsInArabic.favoritePlacesForYou,
                          25.0,
                          AppColors.black),
                      GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myBloc.places.length == 0
                            ? 4
                            : myBloc.places.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent:
                              MediaQueryValues(context).height * 1 / 4,
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing:
                              MediaQueryValues(context).width * 1 / 30,
                        ),
                        itemBuilder: (context, item) {
                          // return cardOfPlace(context);
                          if (state is GetFavoritPlacesLoading) {
                            return CardShimmer();
                          }

                          if (state is GetFavoritPlacesSuccess) {
                            return cardOfPlace(context, myBloc.places[item]);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
