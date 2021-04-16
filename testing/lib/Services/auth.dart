import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing/Models/User.dart';

class AuthMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserModel fromeFirebaseUser(UserCredential user) {
    return user != null
        ? UserModel(
            id: user.additionalUserInfo.providerId,
            userName: user.additionalUserInfo.username,
          )
        : null;
  }

  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return fromeFirebaseUser(result);
    } catch (e) {
      print(e);
    }
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return fromeFirebaseUser(result);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    return firebaseAuth.signOut();
  }
}
