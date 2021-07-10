import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';

part 'all_todo_state.dart';

class AllTodoCubit extends Cubit<AllTodoState> {
  final HomeBloc homeBloc;
  late StreamSubscription todosSubscription;
  AllTodoCubit({required this.homeBloc})
      : super(homeBloc.state is HomeLoadSuccess
            ? AllTodoLoadSuccess((homeBloc.state as HomeLoadSuccess).todos)
            : AllTodoLoadInProgress()) {
    todosSubscription = homeBloc.stream.listen((event) {
      if (event is HomeLoadSuccess) {
        emit(AllTodoLoadSuccess((homeBloc.state as HomeLoadSuccess).todos));
      }
    });
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
