import 'package:flutter/cupertino.dart';
import 'package:todowithbloc/data/models/todo_model.dart';

@immutable
abstract class TodoState {
  final List<TodoModel> todos;
  const TodoState({required this.todos});
}

class TodoInitial extends TodoState {
  final List<TodoModel> todos;
  const TodoInitial({required this.todos}):super(todos: todos);
}

class TodoLoading extends TodoState {
  const TodoLoading({required super.todos});
}

class AddTodo extends TodoState {
  const AddTodo({required super.todos});
}

class TodoError extends TodoState {
  final String message;
  const TodoError({required super.todos, required this.message});
}
