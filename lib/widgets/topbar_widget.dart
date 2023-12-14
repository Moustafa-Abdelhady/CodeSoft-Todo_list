import 'package:flutter/material.dart';
import 'package:todo_list/constants/styles/buttonStyle.dart';
import 'package:todo_list/main.dart';

import '../constants/colors.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({super.key, required this.title});

  final String title;

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> {
  final AppColors appColors = AppColors();

  List<Widget> actionsButton() {
    List<Widget> actions = [];
    if (auth.currentUser != null) {
      actions.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton.tonal(
            style: AppButtonTheme.primaryButton(),
            onPressed: () {
              auth.signOut().whenComplete( () => {
                Navigator.pushReplacementNamed(context, '/')
              });
              setState(() {});
            },
            child: const Text('Logout'),
          ),
        ),
      );
    }
    return actions;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Text(
        widget.title,
        style: TextStyle(
          color: AppColors.light,
          fontWeight: FontWeight.bold,
        ),
      ),

      actions: actionsButton(),
    );
  }

}
