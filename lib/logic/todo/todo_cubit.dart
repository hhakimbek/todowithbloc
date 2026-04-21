import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todowithbloc/data/models/todo_model.dart';

import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
    : super(
        TodoInitial(
          todos: [
            TodoModel(
              id: UniqueKey().toString(),
              title: "Go home",
              isDone: true,
            ),
            TodoModel(
              id: UniqueKey().toString(),
              title: "Go shopping",
              isDone: false,
            ),
            TodoModel(
              id: UniqueKey().toString(),
              title: "Go swimming",
              isDone: false,
            ),
          ],
        ),
      );

  void addTodo(String title) async {
    try {
      emit(TodoLoading(todos: state.todos));
      TodoModel model = TodoModel(id: UniqueKey().toString(), title: title,);
      await Future.delayed(Duration(seconds: 2));
      state.todos.add(model);
      emit(AddTodo(todos: state.todos));
    } catch (e) {
      emit(TodoError(todos: state.todos, message: "Nimadir xato ketdi: $e"));
    }
  }
}
