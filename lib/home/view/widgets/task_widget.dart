import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/home/bloc/home_bloc.dart';
import 'package:todo_list/home/bloc/home_event.dart';

import '../../data/models/todo_model.dart';

class Task extends StatefulWidget {
  Task({
    super.key,
    required this.todo,
    this.state = false,
  });

  late Todo todo;
  late bool state;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool _done = false;
  IconData _stateIcon = Icons.done;

  void _setDone() {
    setState(() {
      _done = true;
      _stateIcon = Icons.close;
    });
  }

  void _setUndone() {
    setState(() {
      _done = false;
      _stateIcon = Icons.done;
    });
  }

  @override
  void initState() {
    if (widget.todo.state) {
      _setDone();
    } else {
      _setUndone();
    }
    super.initState();
  }

  TextDecoration doneTextStyle() {
    return _done ? TextDecoration.lineThrough : TextDecoration.none;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.second.withAlpha(980),
      child: ListTile(
        title: Text(
          widget.todo.title,
          style: TextStyle(color: Colors.black, decoration: doneTextStyle()),
        ),
        subtitle: Text(
          widget.todo.description,
          style: TextStyle(decoration: doneTextStyle()),
          textAlign: TextAlign.justify,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Colors.amber,
          // delete
          onPressed: () {
            context
                .read<TodosBloc>()
                .add(DeleteTodoEvent(todoId: widget.todo.id));
          },
        ),
      ),
    );
  }
}
