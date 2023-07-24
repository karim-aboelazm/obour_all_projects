import 'package:carezone/models/advice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resourses/Color_manager.dart';
import '../resourses/values_manager.dart';

class AdviceScreen extends StatelessWidget {
  final int x;

  const AdviceScreen(this.x, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adviceTitle = advice[x]['Title'].toString();
    final adviceDescription = advice[x]['description'].toString();
    final adviceImage = advice[x]['Image'].toString();

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
