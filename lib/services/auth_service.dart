import 'package:bellshub/models/currentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // parse the user to my currentUser model
  CurrentUser _userFromFirebaseUser(User user) {
    return user != null ? CurrentUser(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, password) async {
    try {
      // AuthResult
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('signInWithEmailAndPassword error : $e');
    }
  }

  Future signUpWithEmailAndPassword(String email, password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('signUpWithEmailAndPassword error: $e');
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('reset Password error: $e');
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('signOut error: $e');
    }
  }
}
