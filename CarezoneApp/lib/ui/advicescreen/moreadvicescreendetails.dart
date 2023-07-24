
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/advice.dart';
import '../resourses/Color_manager.dart';
import '../resourses/values_manager.dart';

class MoreAdviceScreenDetails extends StatelessWidget {
  final int x;
  const MoreAdviceScreenDetails({Key? key, required this.x}) : super(key: key);
  String get adviceTitle => moreadvice[x]['Title'].toString();
  String get adviceDescription => moreadvice[x]['description'].toString();
  String get adviceImage => moreadvice[x]['Image'].toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 26,
                color: ColorManager.black,
              ),
            ),
            backgroundColor: Colors.white,
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                adviceImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  adviceTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: AppSize.s25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    adviceDescription,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.roboto(
                      fontSize: AppSize.s18,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
