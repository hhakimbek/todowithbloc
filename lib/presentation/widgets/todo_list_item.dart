import 'package:flutter/material.dart';
import 'package:todowithbloc/data/models/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final TodoModel todo;
  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      leading: Icon(todo.isDone? Icons.check_circle:Icons.circle_outlined ,),
    );
  }
}
