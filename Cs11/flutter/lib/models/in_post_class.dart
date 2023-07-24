import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kemet/models/place_hint.dart';
import 'dart:convert';

class PlaceInPost {
  String type = 'place';
  PlaceHint? placeHint;
  TextEditingController searchController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  toJson() {
    if (placeHint == null) {
      return null;
    }
    return {
      "type": type,
      "place_id": placeHint!.id,
      "text": commentController.text,
    };
  }
}

class TextInPost {
  String type = "text";
  TextEditingController controller = TextEditingController();

  toJson() {
    if (controller.text.isEmpty) {
      return null;
    }
    return {
      "type": type,
      "text": controller.text,
    };
  }
}

class ImageInPost {
  String type = "image";
  XFile image;
  ImageInPost(this.image);

  Map<String, dynamic> toJson() {
    /*List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64.encode(imageBytes);*/
    return {
      "type": type,
      "img": MultipartFile.fromFileSync(image.path, filename: image.name),
    };
  }
}
