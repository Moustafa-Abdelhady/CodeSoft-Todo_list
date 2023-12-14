import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/features/auth/login/bloc/login_bloc.dart';
import 'package:todo_list/widgets/InputField.dart';
import 'package:todo_list/widgets/topbar_widget.dart';

import '../../bloc/login_event.dart';
import '../../bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  bool disabled = true;

  void _isDisabled() {
    disabled = _email.text.isEmpty | _password.text.isEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: const TopBar(title: 'Login'),
      body: buildBloc(),
    );
  }

  Widget buildBloc() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is SuccessLogin) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case FailureLogin:
            return loginForm(context);
          case Loaded:
            return const Center(child: CircularProgressIndicator());
          default:
            return loginForm(context);
        }
      },
    );
  }

  Widget loginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome To Todo',
                  style: TextStyle( 
                      color: Theme.of(context).primaryColorLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                AppInput(
                  label: 'Email',
                  controller: _email,
                  changeHandelr: (value) => _isDisabled(),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppInput(
                  label: 'Password',
                  secure: true,
                  controller: _password,
                  changeHandelr: (value) => _isDisabled(),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.tonal(
                    onPressed: disabled
                        ? null
                        : () {
                            print('here');
                            context.read<LoginBloc>().add(LoginUserEvent(
                                email: _email.text, password: _password.text));
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColorLight,
                      ),
                      shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)))),
                      textStyle: MaterialStatePropertyAll(
                        TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 25,
                        ),
                      ),
                      overlayColor: MaterialStatePropertyAll(AppColors.light),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Login"),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
