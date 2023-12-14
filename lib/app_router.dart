import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/auth/login/bloc/login_bloc.dart';
import 'package:todo_list/features/auth/login/view/screens/login.dart';
import 'package:todo_list/home/bloc/home_bloc.dart';
import 'package:todo_list/home/view/screens/home_screen.dart';

import 'main.dart';

class AppRoute {

  Widget buildLoginScreen() {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: const LoginPage(),
    );
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        if (auth.currentUser != null) {
          return MaterialPageRoute(builder: (_) {
            return BlocProvider(
              create: (BuildContext context) => TodosBloc(),
              child: const HomeScreen(),
            );
          });
          // return MaterialPageRoute(builder: (_) => const HomePage());
        }
        return MaterialPageRoute(builder: (_) => buildLoginScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => buildLoginScreen());
    }

    return null;
  }
}
