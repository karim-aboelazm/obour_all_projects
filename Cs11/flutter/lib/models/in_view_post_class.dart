import '../helper/end_points.dart';
import 'place_hint.dart';

class PlaceViewInPost {
  String type = 'place';
  late PlaceHint placeHint;
  String? comment;

  PlaceViewInPost.fromJson(json) {
    comment = json['text'];
    placeHint = PlaceHint(
      id: json['place']['id'].toString(),
      name: json['place']['name'],
      image: "${AppEndPoints.baseUrl}${json['place']['main_image']}",
    );
  }
}

class TextViewInPost {
  String type = "text";
  late String text;

  TextViewInPost.fromJson(json) {
    text = json['text'];
  }
}

class ImageViewInPost {
  String type = "image";
  late String image;

  ImageViewInPost.fromJson(json) {
    image = json['img'];
  }
}
