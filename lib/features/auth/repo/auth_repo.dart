import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  static final auth = FirebaseAuth.instance;

  static Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> singInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> sendEmailVerification() async {
    await auth.currentUser!.sendEmailVerification();
  }

  static get uid {
    return auth.currentUser!.uid;
  }

  static Future<bool> checkEmailVerified() async {
    bool emailVerified = auth.currentUser!.emailVerified;
    return emailVerified == true;
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> logOut() async {
    await auth.signOut();
  }
}
