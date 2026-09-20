import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowithbloc/data/models/todo_model.dart';
import 'package:todowithbloc/logic/todo/todo_cubit.dart';

import '../../logic/todo/todo_state.dart';

class ManageTodo extends StatelessWidget {
  final TodoModel? todo;
  ManageTodo({super.key, this.todo});

  final _formKey = GlobalKey<FormState>();
  String _title = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is AddTodo || state is TodoEdited) {
          Navigator.pop(context);
        }
        else if (state is TodoError) {
          showDialog(context: context,
              builder: (ctx) => AlertDialog(content: Text(state.message),));
        }
      },
      child: SafeArea(
        child: SingleChildScrollView( // MUHIM
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom + 20,
            ),
            child: Form(
              key: _formKey,
              child: Column( // Wrap o‘rniga Column
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: todo==null?'':todo?.title??'',
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Title",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter title";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _title = newValue!,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () => _submit(context),
                        child: Text(todo==null?"Add":'Edit'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) { // TO‘G‘RI
      _formKey.currentState!.save();
      if(todo==null) {
       context.read<TodoCubit>().addTodo(_title);
      } else {
        todo!.title = _title;
       context.read<TodoCubit>().editTodo(todo! );
      }
    }
  }
}