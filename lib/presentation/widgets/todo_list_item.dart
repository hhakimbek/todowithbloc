import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowithbloc/data/models/todo_model.dart';
import 'package:todowithbloc/logic/todo/todo_cubit.dart';

import 'manage_todo.dart';

class TodoListItem extends StatelessWidget {
  final TodoModel todo;

  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title,style: TextStyle(decoration: todo.isDone?TextDecoration.lineThrough:null),),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          IconButton(
            onPressed: () => openManageTodo(context),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      leading: IconButton(
        onPressed: () {
          context.read<TodoCubit>().toogleTodo(todo.id);
        },
        icon: Icon(todo.isDone ? Icons.check_circle : Icons.circle_outlined),
      ),
    );
  }

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ManageTodo(todo: todo),
    );
  }
}
