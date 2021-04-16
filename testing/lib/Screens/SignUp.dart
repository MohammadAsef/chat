import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:testing/Screens/Home.dart';
import 'package:testing/Services/auth.dart';
import 'package:testing/Services/database.dart';
import 'package:testing/Widgets/FormInput.dart';

class SignUpScreen extends StatefulWidget {
  static final routName = '/signUp';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isloading = false;

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retypePassword = TextEditingController();

  void signUp() async {
    if (formKey.currentState.validate()) {
      Map<String, dynamic> user = {
        "email": email.text,
        "username": username.text,
      };
      try {
        setState(() {
          isloading = true;
        });
        AuthMethods().signUpWithEmail(email.text, password.text).then((value) {
          setState(() {
            isloading = false;
          });
          if (value != null) {
            DatabaseServices().uploadUserInfo(user);
            Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
          } else {
            scaffoldKey.currentState.showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "Something went wrong",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                ),
              ),
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  FormInput(
                    icon: Icons.person,
                    label: 'UserName',
                    controlller: username,
                    validator: (String val) {
                      if (val == null) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  FormInput(
                    icon: Icons.person,
                    label: 'Email',
                    controlller: email,
                    validator: (String val) {
                      if (val == null && !val.contains('@')) {
                        return 'Please Enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  FormInput(
                    icon: Icons.person,
                    label: 'Password',
                    obsecureText: true,
                    controlller: password,
                    validator: (String val) {
                      if (val.length <= 6) {
                        return 'Password must be at least 6 character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  FormInput(
                    icon: Icons.person,
                    label: 'RetypePassword',
                    obsecureText: true,
                    controlller: retypePassword,
                    validator: (String val) {
                      if (val != password.text) {
                        return 'Password not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 45),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.orange,
                child: isloading == false
                    ? Text(
                        "SignUp",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    : Center(
                        child: SizedBox(
                          height: 20,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                onPressed: signUp,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    text: 'I have account ',
                    children: [
                      TextSpan(text: '    '),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          },
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
