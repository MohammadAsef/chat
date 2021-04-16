import 'package:flutter/material.dart';
import 'package:testing/Models/Message.dart';
import 'package:testing/Services/database.dart';
import 'package:testing/Widgets/message.dart';
import 'package:testing/constants/currentUser.dart';

class ChatRoom extends StatefulWidget {
  static final routName = '/chatRoom';
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController _controller = TextEditingController();
  String message = "";
  String userId;

  @override
  void didChangeDependencies() {
    userId = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    await DatabaseServices().uploadMessage(userId, message);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chatting"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          StreamBuilder<List<MessageModel>>(
            stream: DatabaseServices().getMessages(userId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text('Something Went Wrong Try later'),
                    );
                  } else {
                    final messages = snapshot.data;

                    return messages.isEmpty
                        ? Center(
                            child: Text('Say Hi..'),
                          )
                        : ListView.builder(
                            // physics: BouncingScrollPhysics(),
                            // reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];

                              return Message(
                                message: message,
                                isMe: message.userId == currentUserId,
                              );
                            },
                          );
                  }
              }
            },
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      labelText: 'Type your message',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0),
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onChanged: (value) => setState(() {
                      message = value;
                    }),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: message.trim().isEmpty ? null : sendMessage,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
