import 'dart:convert';

import 'package:kemet/models/in_view_post_class.dart';

class Post {
  int id;
  var postedAt;
  String userName;
  String commentsCount;
  List content;
  //TODO: add postContent
  Post({
    required this.id,
    required this.userName,
    required this.postedAt,
    required this.commentsCount,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> _json) {
    List content = [];
    for (int i = 0; i < _json['contents'].length; i++) {
      if (_json['contents'][i]['type'] == 'place') {
        print('content-place: ${_json['contents'][i]}');
        content.add(PlaceViewInPost.fromJson(_json['contents'][i]));
        continue;
      }
      if (_json['contents'][i]['type'] == 'text') {
        print('content-text: ${_json['contents'][i]}');
        content.add(TextViewInPost.fromJson(_json['contents'][i]));
        continue;
      }
      if (_json['contents'][i]['type'] == 'image') {
        print('content-image: ${_json['contents'][i]}');
        content.add(ImageViewInPost.fromJson(_json['contents'][i]));
      }
    }
    print("object");
    return Post(
      id: _json['id'],
      userName: _json['user']['username'],
      postedAt: _json['created_at'],
      commentsCount: _json['comments_count'].toString(),
      content: content,
    );
  }
  toJson() {
    return {
      'id': id,
      'userName': userName,
      'postedAt': postedAt,
      'commentsCount': commentsCount,
    };
  }
}
