import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytask_frontend/models/user_model.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Sign Up User Method
  Future<void> signUpUser(UserModel user) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    if (userCredential.user != null) {
      UserModel finalUser = UserModel(
        userID: userCredential.user!.uid,
        name: user.name,
        email: user.email,
        password: user.password,
        fcmToken: '',
      );
      await _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(finalUser.toJson());
    } else {
      print('User already exists');
    }
  }

  // Sign In User Method
  Future<void> signInUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
