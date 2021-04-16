import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/Models/Message.dart';
import 'package:testing/Models/User.dart';
import 'package:testing/constants/currentUser.dart';
import 'package:testing/helper/utills.dart';

class DatabaseServices {
  uploadUserInfo(user) async {
    await FirebaseFirestore.instance.collection("users").add(user);
  }

  Stream<List<UserModel>> getUserFromDatabase() {
    return FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .transform(Utils.transformer(UserModel.fromJson));
  }

  createChatRoom(String chatRoomId, chatRoomMap) async {
    await FirebaseFirestore.instance
        .collection("chatMessage/$chatRoomId/messages")
        .add(chatRoomMap);
  }

  Stream<List<MessageModel>> getMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chatMessage/$chatRoomId/messages')
        .orderBy("createdAt", descending: false)
        .snapshots()
        .transform(Utils.transformer(MessageModel.fromJson));
  }

  uploadMessage(String idUser, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chatMessage/$idUser/messages');

    final newMessage = MessageModel(
      userId: currentUserId,
      message: message,
    );
    await refMessages.add({
      'userId': newMessage.userId,
      'message': newMessage.message,
      'createdAt': DateTime.now().toUtc(),
    });
  }
}
