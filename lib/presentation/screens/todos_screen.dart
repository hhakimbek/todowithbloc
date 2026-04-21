import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowithbloc/logic/todo/todo_cubit.dart';
import 'package:todowithbloc/logic/todo/todo_cubit.dart';

import '../../logic/todo/todo_state.dart';
import '../widgets/manage_todo.dart';
import '../widgets/todo_list_item.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Todos"),
        actions: [
          IconButton(
            onPressed: () => openManageTodo(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return TodoListItem(todo: state.todos[index]);
                },
              );
            },
          ),
          BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              if(state is TodoLoading) {
                return Center(child: CircularProgressIndicator(),);
              } else {
                return SizedBox.shrink();
              }
            },
          ),

        ],
      ),
    );
  }

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ManageTodo(),
    );
  }
}
