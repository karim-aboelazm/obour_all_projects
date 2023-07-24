import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/models/in_post_class.dart';
import 'package:kemet/modules/create_post/create_post_cubit.dart';
import 'package:kemet/modules/place_search_page/place_search_page_screen.dart';
import 'package:kemet/modules/widgets/widgets.dart';
import '../../core/colors.dart';
import '../../core/media_query_values.dart';
import '../../core/strings.dart';
import '../../models/place_hint.dart';

Widget invisibleTextField(controller, {String? lable, String? hint}) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
    child: TextFormField(
      minLines: 1,
      maxLines: 7,
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        labelText: lable,
        hintText: hint,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    ),
  );
}

/*
Widget placeCard(index) {
  return BlocProvider(
    create: (context) => CreatePostCubit(),
    child: BlocBuilder(
      builder: (context, state) {
        var mycubit = BlocProvider.of<CreatePostCubit>(context);
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                width: MediaQueryValues(context).width - 40,
                child: Column(
                  children: [
                    mycubit.contentList[index]
                    PlaceInContext(context, place.name, place.image),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: invisibleTextField(controller),
                    ),
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
*/
SelectPlaceCard(context, int index) {
  return BlocConsumer<CreatePostCubit, CreatePostState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      var mycubit = BlocProvider.of<CreatePostCubit>(context);
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              width: MediaQueryValues(context).width - 40,
              //height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  mycubit.contentList[index].placeHint == null
                      ? Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: InkWell(
                            onTap: () {
                              navigateTo(
                                  context, PlaceSearchPage(index: index));
                            },
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: AppStringsInEnglish.search,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary, //Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    15, 15, 15, 15),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Icon(Icons.search_rounded),
                                ),
                              ),
                            ),
                          ),
                        )
                      : PlaceInContext(
                          context, mycubit.contentList[index].placeHint),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: invisibleTextField(
                        mycubit.contentList[index].commentController,
                        lable: AppStringsInEnglish.commentThePlace),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget imageInPostWedgit(int index) {
  return BlocBuilder<CreatePostCubit, CreatePostState>(
    builder: (context, state) {
      var mycubit = BlocProvider.of<CreatePostCubit>(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(mycubit.contentList[index].image.path),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: 300,
          ),
        ),
      );
    },
  );
}
