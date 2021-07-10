import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app_bloc/screens/home/cubit/incomplete_todo_cubit.dart';
import 'package:todo_app_bloc/screens/home/home.dart';

class IncompleteTodoScreen extends StatelessWidget {
  const IncompleteTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incomplete TODO'),
      ),
      body: BlocBuilder<IncompleteTodoCubit, IncompleteTodoState>(
          builder: (ctx, state) {
        if (state is IncompleteTodoLoadInProgress) {
          EasyLoading.show();
          return SizedBox.shrink();
        } else if (state is IncompleteTodoLoadSuccess) {
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
