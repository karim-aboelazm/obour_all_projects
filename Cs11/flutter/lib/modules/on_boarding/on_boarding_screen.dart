import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/modules/navigation_bar/home_screen_and_navigation_bar.dart';
import 'package:kemet/modules/widgets/on_boarding.dart';
import 'package:kemet/modules/widgets/widgets.dart';

class OnBoardingModel {
  String? img;
  String? title;
  String? description;
  String? descriptionPart1;

  OnBoardingModel(
      {required this.title,
      required this.img,
      required this.description,
      this.descriptionPart1});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnBoardingModel> listOnBoardingModel = [
    OnBoardingModel(
      img: AppStringsInEnglish.onBoardingModelImage1,
      title: AppStringsInEnglish.onBoardingModelTitle1,
      description: AppStringsInEnglish.onBoardingModelDescription1part2,
      descriptionPart1: AppStringsInEnglish.onBoardingModelDescription1part1,
    ),
    OnBoardingModel(
      img: AppStringsInEnglish.onBoardingModelImage2,
      title: AppStringsInEnglish.onBoardingModelTitle2,
      description: AppStringsInEnglish.onBoardingModelDescription2,
    ),
    OnBoardingModel(
      img: AppStringsInEnglish.onBoardingModelImage3,
      title: AppStringsInEnglish.onBoardingModelTitle3,
      description: AppStringsInEnglish.onBoardingModelDescription3,
    ),
  ];
  PageController pageController = PageController();
  // TODO: use the value of search
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        itemCount: listOnBoardingModel.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQueryValues(context).height * 3 / 4.5,
                  color: Colors.orangeAccent,
                  child: Image.asset(
                    listOnBoardingModel[index].img.toString(),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    listOnBoardingModel[index].title.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                index == 0
                    ? Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text: listOnBoardingModel[index]
                                    .descriptionPart1
                                    .toString(),
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 25),
                              ),
                              TextSpan(
                                  text: listOnBoardingModel[index]
                                      .description
                                      .toString(),
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 16))
                            ]),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          listOnBoardingModel[index].description.toString(),
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 13,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                if(index==2)
                  searchField(context: context,textEditingController: textEditingController),
                defaultButton(
                  r: 16,
                  text: index == 2
                      ? AppStringsInEnglish.getStarted
                      : AppStringsInEnglish.next,
                  color: AppColors.primary,
                  function: () {
                    if (index < 2) {
                      setState(() {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      });
                    } else {
                      navigateToAndReplacement(context, const HomeScreenAndNavigationBar());
                    }
                  },
                  context: context,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
