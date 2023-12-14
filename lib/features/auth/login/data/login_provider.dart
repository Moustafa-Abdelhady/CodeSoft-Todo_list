import 'dart:async';
import 'package:todo_list/main.dart';

/// [
/// UserInfo(
///   displayName: null,
///   email: islam@admin.com,
///   phoneNumber: null,
///   photoURL: null,
///   providerId: password,
///   uid: islam@admin.com
/// )]
class Auth {
  Auth({required this.email, required this.password});

  late final String email;
  late final String password;

  FutureOr<User> login() async {
    User userInfo = User();

    final userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      userInfo = User(displayName: user.displayName, email: user.email, photoUrl: user.photoURL);
    }
    return userInfo;
  }
}

class User{
  late final String? displayName;
  late final String? email;
  late final String? photoUrl;

  User({this.displayName, this.email, this.photoUrl});
}