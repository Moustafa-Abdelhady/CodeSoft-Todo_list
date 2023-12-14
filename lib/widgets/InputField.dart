import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';

typedef OnChangeCallback = void Function(String value);

class AppInput extends StatefulWidget {
  AppInput({super.key, required this.label, this.secure, this.controller, this.changeHandelr, this.maxLines = 1, this.value });

  final String label;
  final bool? secure;
  final TextEditingController? controller;
  final OnChangeCallback? changeHandelr;
  late int? maxLines;
  late String? value;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late final Color light =  AppColors.light;
  late Color labelColor =  AppColors.second;

  final _focus = FocusNode();

  @override
  void initState() {
    _focus.addListener(() {
      _focus.hasFocus ? _focusInput() : _focusLost();
    });
    super.initState();
  }

  void _focusInput() {
    setState(() {
      labelColor = light;
    });
  }

  void _focusLost() {
    setState(() {
      labelColor =  AppColors.second;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.value,
      maxLines: widget.maxLines,
      controller: widget.controller,
      obscureText: widget.secure ?? false,
      onChanged: widget.changeHandelr,
      cursorColor: light,
      focusNode: _focus,
      style: TextStyle(
        color: light,
      ),
      decoration: InputDecoration(

        labelText: widget.label,
        labelStyle: TextStyle(color: labelColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: light,
          ),
        ),
        focusColor: Colors.blue,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: light),
        ),
      ),
    );
  }
}
