import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/helper/end_points.dart';
import 'package:kemet/models/place_model.dart';
import 'package:kemet/modules/directions/place_directions/place_directions_screen.dart';
import 'package:kemet/modules/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/place_details.dart';
import 'place_details_cubit.dart';

//TODO: use the real data.
String title = "الكنيسة المعلقة";
double placeRating = 5;
double userRating = 0;
String shortDiscryption = "مبني أثري قبطي";
String fees = "الدخول مجانا";
String briefHistory =
    'تقع الكنيسة المعلقة في حي مصر القديمة، في منطقة القاهرة القبطية الأثرية الهامة، فهي على مقربة من جامع عمرو بن العاص، ومعبد بن عزرا اليهودي، وكنيسة القديس مينا بجوار حصن بابليون، وكنيسة الشهيد مرقوريوس (أبو سيفين)، وكنائس عديدة أخرى. وسميت بالمعلقة لأنها بنيت على برجين من الأبراج القديمة للحصن الروماني[؟] (حصن بابليون)، ذلك الذي كان قد بناه الإمبراطور تراجان في القرن الثاني الميلادي، وتعتبر المعلقة هي أقدم الكنائس التي لا تزال باقية في مصر ( أعرف أكتر )';
String location = "حي مصر القديمة، على شارع ماري جرجس";
String NMS = "أقرب محطة مترو للكنيسة المعلقة هي مارجرجس";

List<String> imags = [
  'assets/images/placeImage.jpg',
  'assets/images/placeImage.jpg',
  'assets/images/placeImage.jpg'
];

class PlaceView extends StatelessWidget {
  PlaceView({super.key, required this.place});
  Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocProvider(
        create: (BuildContext context) => PlaceDetailsCubit(),
        child: BlocConsumer<PlaceDetailsCubit, PlaceDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var myBloc = BlocProvider.of<PlaceDetailsCubit>(context);
            return detailedScreenDraft(
        context,
        title: place.name,
        imageLink: place.main_Image,
        headCardItem: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
              child: RatingBar.builder(
                ignoreGestures: true,
                initialRating: double.parse(place.rate),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 15,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) {},
                    ),
                  ),
                  Text("${place.rate.toString()}/5"),
                ],

              ),
              children: [

                const SizedBox(),
                headNote(
                  context,
                  text: AppStringsInArabic.generalInfo,
                  icon: Icons.content_paste,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                  child: Row(
                    children: [
                      // Icon(
                      //   FontAwesomeIcons.dollarSign,
                      //   size: 25,
                      // ),
                      Text(
                        "EGP ${place.price.toString()}",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        AppStringsInArabic.rate,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: RatingBar.builder(
                    initialRating: userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 30,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    // TODO : send the rating
                    onRatingUpdate: (rating) {
                      myBloc.ratePlace(context, place.id, rating);
                    },
                  ),
                ),
                /*defaultButton(
                  r: 5,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  text: AppStringsInArabic.save,
                  color: const Color.fromARGB(255, 228, 164, 37),
                  // TODO : send the rating
                  function: () {

                  },
                  context: context,
                ),*/
                const SizedBox(),
                headNote(context, text: AppStringsInArabic.briefHistory),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: Text(
                    place.info,
                    textAlign: TextAlign.end,
                  ),
                ),
                headNote(context, text: AppStringsInArabic.location),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    place.location_text,
                  ),
                ),
                // Text(
                //   NMS,
                // ),
                const SizedBox(height: 5),
                defaultButton(
                  r: 5,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  text: AppStringsInArabic.directions,
                  color: const Color.fromARGB(255, 228, 164, 37),
                  //TODO : HELP !!!!!!!!!!!!!
                  function: () {
                    navigateTo(
                        context,
                        PlaceDirections(
                          title: place.name,
                          placeRating: double.parse(place.rate),
                          image: place.main_Image,
                        ));
                  },
                  context: context,
                ),

                const SizedBox(),

                headNote(context, text: AppStringsInArabic.gallery),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                  child: SizedBox(
                    height: 160,
                    child: ListView.builder(
                      itemCount: place.gallery.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(15)),
                              border: Border.all(color: AppColors.orange),
                            ),
                            child: Image.network(
                              place.gallery[index],
                              width: 120,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                /*Container(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imags.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  imags[index],
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),*/

                //headNote(context, text: AppStringsInArabic.reviews)
                //TODO: add the post component.
              ],
            );
          },
        ),
      ),
    );
  }
}
