import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/helper/shimmer/card_shimmer.dart';
import 'package:kemet/models/city.dart';
import 'package:kemet/modules/city_details/city_details_cubit.dart';
import 'package:kemet/modules/place_details/place_details_screen.dart';
import 'package:kemet/modules/widgets/home_screen_widgets.dart';
import 'package:kemet/modules/widgets/place_details.dart';

import '../../helper/end_points.dart';

class CityView extends StatelessWidget {
  final City city;
  const CityView({required this.city, super.key});

  @override
  Widget build(BuildContext context) {
    return detailedScreenDraft(
      context,
      title: city.name,
      imageLink: '${AppEndPoints.baseUrl}${city.main_Image}',
      headCardItem: Text(city.nick_name),
      children: [
        headNote(context, text: AppStringsInArabic.generalInfo),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("AKA : ${city.nick_name}"),
              Text("Name : ${city.name}"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Area : ${city.area}"),
            ],
          ),
        ),
        headNote(context, text: AppStringsInArabic.briefHistory),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Text(
            city.info,
            textAlign: TextAlign.end,
          ),
        ),
        headNote(context, text: AppStringsInArabic.famousPlaces),
        BlocProvider(
          create: (context) =>
              CityDetailsCubit()..getPlaces(context: context, cityId: city.id),
          child: BlocConsumer<CityDetailsCubit, CityDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              var myBloc = BlocProvider.of<CityDetailsCubit>(context);
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                child: SizedBox(
                  height: MediaQueryValues(context).height * 0.26,
                  child: ListView.builder(
                    itemCount: myBloc.placesList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (state is GetPlacesLoading) {
                        return const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: CardShimmer(),
                        );
                      }
                      return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: cardOfPlace(context, myBloc.placesList[index]),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
