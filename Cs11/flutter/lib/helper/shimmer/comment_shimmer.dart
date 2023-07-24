import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kemet/core/media_query_values.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/colors.dart';

class CommentShimmer extends StatelessWidget {
  const CommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.grey,
              highlightColor: AppColors.primary,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/account_avatar.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: AppColors.grey,
              highlightColor: AppColors.primary,
              child: Container(
                height: 25,
                width: MediaQueryValues(context).width * 0.30,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 20),
          child: Shimmer.fromColors(
              baseColor: AppColors.grey,
              highlightColor: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    width: MediaQueryValues(context).width * 0.75,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 25,
                    width: MediaQueryValues(context).width * 0.50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
