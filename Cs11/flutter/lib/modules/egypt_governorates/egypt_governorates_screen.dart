import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/modules/widgets/home_screen_widgets.dart';
import 'package:kemet/core/media_query_values.dart';

import '../../helper/shimmer/card_shimmer.dart';
import '../widgets/snackbar_widget.dart';
import '../widgets/widgets.dart';
import 'egypt_governorates_cubit.dart';

class EgyptGovernoratesScreen extends StatelessWidget {
  const EgyptGovernoratesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
        ),
        title: const Text(
          AppStringsInArabic.egyptGovernorates,
          style: TextStyle(fontSize: 18, fontFamily: 'Tajawal'),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            EgyptGovernoratesCubit()..getCities(context: context),
        child: BlocConsumer<EgyptGovernoratesCubit, EgyptGovernoratesState>(
          listener: (context, state) {},
          builder: (context, state) {
            var myBloc = BlocProvider.of<EgyptGovernoratesCubit>(context);
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: state is GetCitiesLoading,
                      builder: (context) => GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          defaultButton(
                            r: 5,
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.4,
                            text: AppStringsInEnglish.previous,
                            color: const Color.fromARGB(255, 228, 164, 37),
                            function: () {
                              if (myBloc.previous == null) {
                                showSnackBar(
                                    context: context,
                                    text: 'This is the first page',
                                    clr: Colors.blue);
                                return;
                              }
                              myBloc.goToPreviousPage(context: context);
                            },
                            context: context,
                          ),
                          defaultButton(
                            r: 5,
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.4,
                            text: AppStringsInEnglish.next,
                            color: const Color.fromARGB(255, 228, 164, 37),
                            function: () {
                              if (myBloc.next == null) {
                                showSnackBar(
                                    context: context,
                                    text: 'This is the last page',
                                    clr: Colors.blue);
                                return;
                              }
                              myBloc.goToNextPage(context: context);
                            },
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
