import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/constants/styles/buttonStyle.dart';
import 'package:todo_list/home/bloc/home_bloc.dart';
import 'package:todo_list/home/bloc/home_event.dart';
import 'package:todo_list/home/bloc/home_state.dart';
import 'package:todo_list/widgets/topbar_widget.dart';

import '../../../main.dart';
import '../../../widgets/InputField.dart';
import '../../data/models/todo_model.dart';
import '../widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  late List<Todo> allTodos = [];

  @override
  void initState() {
    context.read<TodosBloc>().add(GetAllTodosEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.dark,
        appBar: const TopBar(title: 'Todos List'),
        floatingActionButton: IconButton(
          onPressed: () {
            showDialog(context: context, builder: (_) => newTodoDialog());
          },
          icon: const Icon(Icons.add),
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: AppColors.dark),
              ),
            ),
          ),
        ),
        body: buildBloc());
  }

  Widget buildBloc() {
    return BlocConsumer<TodosBloc, TodosState>(
      builder: (context, state) {
        return todosList();
      },
      listener: (context, state) {
        if (state is SuccessGettingTodos) {
          allTodos = state.todos;
          setState(() {});
        }
        if (state is SuccessUpdateTodoState) {
          context.read<TodosBloc>().add(GetAllTodosEvent());
        }
        if (state is SuccessDeleteTodo) {
          context.read<TodosBloc>().add(GetAllTodosEvent());
        }
        if (state is SuccessCreateTodo) {
          context.read<TodosBloc>().add(GetAllTodosEvent());
        }
      },
    );
  }

  Widget progressBar() {
    return Center(
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              color: AppColors.second,
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Getting Todos',
              style: TextStyle(color: AppColors.light),
            ),
          ],
        ),
      ),
    );
  }
// delete
  Widget dismissible({required Widget child, required int todoIndex}) {
    return Dismissible(
      key: GlobalKey(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(20),
        color: Colors.blue,
        child: Icon(
          Icons.delete,
          color: AppColors.light,
          size: 32,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => {
        context
          .read<TodosBloc>()
          .add(DeleteTodoEvent(todoId: allTodos[todoIndex].id))
      },
      child: child,
    );
  }

  Widget buildListTodos() {
    return ListView.builder(
      itemCount: allTodos.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => newTodoDialog(element: allTodos[index]));
          },
          child: Task(state: true, todo: allTodos[index]),
        );
      },
    );
  }

  Widget todosList() {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        margin: const EdgeInsets.only(top: 20),
        child: buildListTodos());
  }

  Widget newTodoDialog({Todo? element}) {
    bool editMode = element != null;
    _title.text = element?.title ?? '';
    _description.text = element?.description ?? '';

    return Dialog(
        surfaceTintColor: AppColors.second,
        backgroundColor: AppColors.dark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                AppInput(
                  label: 'Title',
                  controller: _title,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppInput(
                  label: 'Description',
                  maxLines: null,
                  controller: _description,
                ),
                const SizedBox(
                  height: 20,
                ),
                FilledButton.tonal(
                  style: AppButtonTheme.primaryButton(),
                  onPressed: () {
                    final Todo todo = Todo.fromJson({
                      'title': _title.text,
                      'description': _description.text,
                      'user': auth.currentUser?.uid
                    });
                    if (editMode) {
                      element.title = _title.text;
                      element.description = _description.text;
                      context
                          .read<TodosBloc>()
                          .add(EditTodoEvent(todoNew: element));
                    } else {
                      context
                          .read<TodosBloc>()
                          .add(CreateTodoEvent(todo: todo));
                    }
                    Navigator.of(context).pop();
                  },
                  child: editMode ? const Text('Edit') : const Text('Save'),
                )
              ],
            ),
          ),
        ));
  }

  // Widget emptyTodos() {
  //   return Center(
  //     child: Text(
  //       "Todos List Is ",
  //       style: TextStyle(color: AppColors.light),
  //     ),
  //   );
  // }
}
