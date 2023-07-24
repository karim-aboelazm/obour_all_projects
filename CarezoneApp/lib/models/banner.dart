import 'package:flutter/material.dart';

class BannerModel {
  String text;
  List<Color> cardBackground;
  String image;

  BannerModel(this.text, this.cardBackground, this.image);
}

List<BannerModel> bannerCards = [
  BannerModel(
      'Medicine Reminder ',
      [
        const Color(0xffa1d4ed),
        const Color(0xffc0eaff),
      ],
      'images/covid.jpg'),
  BannerModel(
      'X-ray Diagnosis',
      [
        const Color(0xffb6d4fa),
        const Color(0xffcfe3fc),
      ],
      'images/414.jpg'),
];
