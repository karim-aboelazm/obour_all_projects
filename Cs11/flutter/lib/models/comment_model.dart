import 'package:flutter/gestures.dart';
import 'package:kemet/models/user_hint.dart';

class Comment {
  int id;
  String userName;
  String comment;
  String commentedAt;
  bool hasReplays;

  Comment({
    required this.id,
    required this.userName,
    required this.comment,
    required this.commentedAt,
    required this.hasReplays,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    print(json);
    return Comment(
        id: json['id'],
        userName: json['owner']['username'],
        comment: json['text'],
        commentedAt: json['created_at'],
        hasReplays: true //json['hasReplays'],
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userName,
      'comment': comment,
      'commentedAt': commentedAt,
      'hasReplays': hasReplays,
    };
  }
}
