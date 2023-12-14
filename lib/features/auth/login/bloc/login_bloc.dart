import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/auth/login/bloc/login_event.dart';
import 'package:todo_list/features/auth/login/bloc/login_state.dart';

import '../../../../features/auth/login/data/login_provider.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    on<LoginUserEvent>(_loginUser);
  }

  FutureOr<void> _loginUser(
      LoginUserEvent event, Emitter<LoginState> emit) async {

    Auth credential = Auth(email: event.email, password: event.password);
    try {
      emit(Loaded());
      User user = await credential.login();
      emit(SuccessLogin(userInfo: user));
    } catch (_) {
      emit(FailureLogin());
    }

  }

}
