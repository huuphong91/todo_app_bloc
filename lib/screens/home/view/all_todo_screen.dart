import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app_bloc/screens/home/cubit/cubits.dart';
import 'package:todo_app_bloc/screens/home/home.dart';

class AllToDoScreen extends StatelessWidget {
  const AllToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALL TODO'),
      ),
      body: BlocBuilder<AllTodoCubit, AllTodoState>(builder: (ctx, state) {
        if (state is AllTodoLoadInProgress) {
          EasyLoading.show();
          return SizedBox.shrink();
        } else if (state is AllTodoLoadSuccess) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
          final todos = state.allTodos;
          return CustomListView(todos: todos);
        } else {
          return SizedBox.shrink();
        }
      }),
    );
  }
}
