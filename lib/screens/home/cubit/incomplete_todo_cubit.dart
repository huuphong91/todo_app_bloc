import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';

part 'incomplete_todo_state.dart';

class IncompleteTodoCubit extends Cubit<IncompleteTodoState> {
  final HomeBloc? homeBloc;
  late StreamSubscription todosSubscription;
  IncompleteTodoCubit({@required this.homeBloc})
      : super(homeBloc!.state is HomeLoadSuccess
            ? IncompleteTodoLoadSuccess((homeBloc.state as HomeLoadSuccess)
                .todos
                .where((todo) => !todo.complete)
                .toList())
            : IncompleteTodoLoadInProgress()) {
    todosSubscription = homeBloc!.stream.listen((event) {
      if (event is HomeLoadSuccess) {
        emit(IncompleteTodoLoadSuccess((homeBloc!.state as HomeLoadSuccess)
            .todos
            .where((todo) => !todo.complete)
            .toList()));
      }
    });
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
