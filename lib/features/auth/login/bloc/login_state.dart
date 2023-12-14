import '../data/login_provider.dart';

abstract class LoginState {}

class InitialState extends LoginState {}

class SuccessLogin extends LoginState {
  User userInfo;
  SuccessLogin({required this.userInfo});
}

class FailureLogin extends LoginState {}

class Loaded extends LoginState { }