import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:testing/Screens/Home.dart';
import 'package:testing/Screens/SignUp.dart';
import 'package:testing/Services/auth.dart';
import 'package:testing/Widgets/FormInput.dart';
import 'package:testing/constants/currentUser.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void signIn() {
    if (formKey.currentState.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        AuthMethods().signInWithEmail(email.text, password.text).then((value) {
          setState(() {
            isLoading = false;
          });
          if (value != null) {
            currentUserId = email.text;
            Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
          } else {
            scaffoldKey.currentState.showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "Wrong UserName or Password",
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
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.chat,
                size: 80,
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 55),
                  FormInput(
                    label: 'Email',
                    icon: Icons.person,
                    controlller: email,
                    validator: (String val) {
                      if (val == null && !val.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  FormInput(
                    label: 'Password',
                    icon: Icons.lock,
                    obsecureText: true,
                    controlller: password,
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
                child: isLoading == false
                    ? Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                onPressed: signIn,
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
                    text: 'I don\'t have account ',
                    children: [
                      TextSpan(text: '    '),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushNamed(SignUpScreen.routName);
                          },
                        text: 'SignUp',
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
