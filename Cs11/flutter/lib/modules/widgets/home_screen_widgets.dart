import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/helper/end_points.dart';
import 'package:kemet/models/city.dart';
import 'package:kemet/models/place_category.dart';
import 'package:kemet/models/place_model.dart';
import 'package:kemet/modules/%20login_and_signup/sign_in_and_sign_up_cubit.dart';
import 'package:kemet/modules/place_details/place_details_cubit.dart';

import '../../core/navigation.dart';
import '../city_details/city_details_screen.dart';
import '../place_details/place_details_screen.dart';

Widget welcomeWidget(context) {
  return Column(
    children: [
      Container(
        height: MediaQueryValues(context).height * 1 / 9,
        decoration: BoxDecoration(
          color: AppColors.blackWithOpacity,
          borderRadius: BorderRadius.circular(19),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: MediaQueryValues(context).width * 1 / 14,
                backgroundColor: AppColors.primaryLight,
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: MediaQueryValues(context).width * 1 / 19,
                  child: Text(
                    'ENG',
                    style: TextStyle(color: AppColors.black),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        BlocConsumer<SignInAndSignUpCubit,
                            SignInAndSignUpState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Text(
                              BlocProvider.of<SignInAndSignUpCubit>(context)
                                  .userModel!
                                  .username,
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.white,
                                fontFamily: 'Tajawal',
                              ),
                            );
                          },
                        ),
                        Text(
                          AppStringsInArabic.welcomeInHomeScreen,
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.white,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      AppStringsInArabic.governorate,
                      style: TextStyle(
                        color: AppColors.orange,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Image.asset(
                  'assets/images/account_avatar.png',
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget textWidget(context, text, size, textColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontFamily: 'Tajawal',
        fontSize: size.toDouble(),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget categoryWidget(context, PlaceCategory placeCategory) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: MediaQueryValues(context).width * 1 / 3,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: MediaQueryValues(context).height * 1 / 25,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network('${AppEndPoints.baseUrl}${placeCategory.icon}'),
            const Spacer(),
            Text(
              placeCategory.name,
              style: const TextStyle(fontFamily: 'Tajawal'),
            ),
            const Spacer(),
          ],
        ),
      ),
    ),
  );
}

Widget cardOfPlace(context, Place place) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          PlaceView(
            place: place,
          ));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: MediaQueryValues(context).height * 5 / 20,
      width: MediaQueryValues(context).width * 5 / 11,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            // height: MediaQueryValues(context).height * 2 / 14,
            child: Image.network(
              place.main_Image,
              // width: (MediaQueryValues(context).width * 5 / 11) - 20,
              // height: MediaQueryValues(context).height * 5 / 25,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                      fontFamily: 'Tajawal', fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocProvider(
                      create: (BuildContext context) => PlaceDetailsCubit(),
                      child: BlocConsumer<PlaceDetailsCubit, PlaceDetailsState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          var myBloc =
                              BlocProvider.of<PlaceDetailsCubit>(context);
                          return InkWell(
                            onTap: () {
                              //TODO: set the condition
                              if (place.isfav) {
                                myBloc.unFavPlace(context, place.id);
                                return;
                              }
                              myBloc.favPlace(context, place.id);
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.primary,
                              minRadius: 10,
                              child: Icon(Icons.favorite,
                                  size: 15, color: AppColors.white),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      place.city.name,
                      style: TextStyle(fontFamily: 'Tajawal'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget cardOfGov(context, City city) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          CityView(
            city: city,
          ));
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      height: MediaQueryValues(context).height * 5 / 20,
      width: MediaQueryValues(context).width * 5 / 11,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            // height: MediaQueryValues(context).height * 2 / 14,
            child: Image.network(
              '${AppEndPoints.baseUrl}${city.main_Image}',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  city.name,
                  style: const TextStyle(
                      fontFamily: 'Tajawal', fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: AppColors.primary,
                    //   minRadius: 10,
                    //   child: Icon(Icons.favorite,
                    //       size: 15, color: AppColors.white),
                    // ),
                    const Spacer(),
                    Text(
                      city.nick_name,
                      style: const TextStyle(fontFamily: 'Tajawal'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

/*
GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: getVerticalSize(
                        188.00,
                      ),
                      crossAxisCount: 2,
                      mainAxisSpacing: getHorizontalSize(
                        20.00,
                      ),
                      crossAxisSpacing: getHorizontalSize(
                        20.00,
                      ),
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ElkermItemWidget();
                    },
                  ),
 */
/*
Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "عرض المزيد",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtTajawalMedium17Orange600,
              ),
              Text(
                "محافظات مصر",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtTajawalMedium17,
              ),
            ],
          ),
 */
