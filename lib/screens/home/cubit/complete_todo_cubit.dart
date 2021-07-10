import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';

part 'complete_todo_state.dart';

class CompleteTodoCubit extends Cubit<CompleteTodoState> {
  final HomeBloc? homeBloc;
  late StreamSubscription todosSubscription;
  CompleteTodoCubit({@required this.homeBloc})
      : super(homeBloc!.state is HomeLoadSuccess
            ? CompleteTodoLoadSuccess((homeBloc.state as HomeLoadSuccess)
                .todos
                .where((todo) => todo.complete)
                .toList())
            : CompleteTodoLoadInProgress()) {
    todosSubscription = homeBloc!.stream.listen((event) {
      if (event is HomeLoadSuccess) {
        emit(CompleteTodoLoadSuccess(_mapTodosToFilteredTodos(
            (homeBloc!.state as HomeLoadSuccess).todos)));
      }
    });
  }

  List<Todo> _mapTodosToFilteredTodos(List<Todo> todos) {
    return todos.where((todo) {
      return todo.complete;
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
