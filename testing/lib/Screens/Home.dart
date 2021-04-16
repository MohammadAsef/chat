import 'package:flutter/material.dart';
import 'package:testing/Models/User.dart';
import 'package:testing/Screens/ChatRoom.dart';
import 'package:testing/Services/auth.dart';
import 'package:testing/Services/database.dart';

class HomeScreen extends StatefulWidget {
  static final routName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<UserModel> users = [];
  // bool isLoading = true;

  // @override
  // void didChangeDependencies() {
  //   DatabaseServices().getUserFromDatabase().then((value) {
  //     setState(() {
  //       (value.docs as List).forEach((element) {
  //         users.add(UserModel.fromJson(element.data()));
  //       });
  //       isLoading = false;
  //     });
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () async {
            await AuthMethods().signOut();
            Navigator.of(context).pushReplacementNamed("/");
          },
        ),
        title: Text("MyChat"),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Image.asset(
              "assets/images/profile.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: DatabaseServices().getUserFromDatabase(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Something Went Wrong Try later');
              } else {
                final users = snapshot.data;

                if (users.isEmpty) {
                  return Text('No Users Found');
                } else
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (ctx, i) => Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ChatRoom.routName,
                              arguments: users[i].id,
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              "A",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            users[i].userName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {},
      ),
    );
  }
}
