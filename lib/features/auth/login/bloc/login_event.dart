abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  late String email;
  late String password;

  LoginUserEvent({required this.email, required this.password});
}