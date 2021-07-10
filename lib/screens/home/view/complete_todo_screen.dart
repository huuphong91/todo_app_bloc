import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app_bloc/screens/home/cubit/cubits.dart';
import 'package:todo_app_bloc/screens/home/home.dart';

class CompleteToDoScreen extends StatelessWidget {
  const CompleteToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete TODO'),
      ),
      body: BlocBuilder<CompleteTodoCubit, CompleteTodoState>(
          builder: (ctx, state) {
        if (state is CompleteTodoLoadInProgress) {
          EasyLoading.show();
          return SizedBox.shrink();
        } else if (state is CompleteTodoLoadSuccess) {
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
