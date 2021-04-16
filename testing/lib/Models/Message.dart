import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String userId;
  String message;
  Timestamp createdAt;

  MessageModel({
    this.userId,
    this.message,
    this.createdAt,
  });

  static MessageModel fromJson(Map json) {
    print("hello");
    Timestamp current = json["createdAt"];
    print(current);
    return MessageModel(
      userId: json["userId"],
      message: json["message"],
      createdAt: current,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'userId': userId,
  //     'message': message,
  //     'createdAt': DateTime(DateTime.now().year).toUtc(),
  //   };
  // }
}
