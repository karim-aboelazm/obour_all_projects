import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/models/place_hint.dart';
import 'package:kemet/modules/create_post/create_post_cubit.dart';

import '../../core/colors.dart';
import '../../core/strings.dart';
import 'place_search_page_cubit.dart';

class PlaceSearchPage extends StatefulWidget {
  int index;
  PlaceSearchPage({required this.index, super.key});

  @override
  State<PlaceSearchPage> createState() => _PlaceSearchPageState(index);
}

class _PlaceSearchPageState extends State<PlaceSearchPage> {
  int index;
  _PlaceSearchPageState(this.index);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PlaceSearchPageCubit(),
        child: BlocConsumer<PlaceSearchPageCubit, PlaceSearchPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            var myCubit = BlocProvider.of<PlaceSearchPageCubit>(context);
            return Column(
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
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: AppStringsInEnglish.search,
                      hintText: AppStringsInEnglish.search,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary, // Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary, // Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(Icons.search_rounded),
                      ),
                    ),
                    onChanged: (value) {
                      if (controller.text.isNotEmpty) {
                        myCubit.getSearchResuls(context, controller.text);
                      }
                    },
                  ),
                ),
                for (int i = 0; i < myCubit.searchResults.length; i++) ...[
                  BlocBuilder<PlaceSearchPageCubit, PlaceSearchPageState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<CreatePostCubit>(context).selectPlace(
                              index,
                              PlaceHint(
                                  id: myCubit.searchResults[i].id,
                                  name: myCubit.searchResults[i].name,
                                  image: myCubit.searchResults[i].main_Image));
                          Navigator.pop(context);
                        },
                        child: Text(myCubit.searchResults[i].name),
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
    );
  }
}
