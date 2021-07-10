import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';

class CustomListView extends StatelessWidget {
  final List<Todo> todos;
  const CustomListView({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todos.length != 0
        ? ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.note),
                trailing: Checkbox(
                  value: todo.complete,
                  onChanged: (_) {
                    BlocProvider.of<HomeBloc>(context).add(
                      HomeUpdated(todo.copyWith(complete: !todo.complete)),
                    );
                  },
                ),
              );
            },
          )
        : Center(
            child: const Text('No Items'),
          );
  }
}
