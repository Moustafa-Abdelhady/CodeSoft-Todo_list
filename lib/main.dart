import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app_router.dart';
import 'package:todo_list/constants/colors.dart';

import 'firebase_options.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;
late final FirebaseFirestore db;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  runApp(TodosApp(appRoute: AppRoute()));
}

class TodosApp extends StatelessWidget {
  const TodosApp({super.key, required this.appRoute});

  final AppRoute appRoute;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.generateRoute,
      initialRoute: '/',

      title: 'Todos List',
      theme: ThemeData(
        primaryColor: AppColors.dark,
        primaryColorDark: AppColors.dark,
        primaryColorLight: AppColors.second,
        highlightColor: AppColors.highlight,
        cardTheme: CardTheme(color: AppColors.second, elevation: 0),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(AppColors.dark),
            backgroundColor: MaterialStatePropertyAll(AppColors.second),
            overlayColor: MaterialStatePropertyAll(AppColors.light),
            elevation: const MaterialStatePropertyAll(0),
          ),
        ),
        focusColor: AppColors.second,
        hoverColor: AppColors.second,
        hintColor: AppColors.highlight,
        
       
      ),
      // home: BlocProvider(
      //   create: (context) => LoginBloc(),
      //   child: const LoginPage(),
      // ),
    );
  }
}
