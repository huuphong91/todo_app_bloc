import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/repository/todo_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoRepository todoRepository;
  HomeBloc({required this.todoRepository}) : super(HomeLoadInProgress());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeLoaded) {
      yield* _mapTodosLoadedToState();
    } else if (event is HomeUpdated) {
      yield* _mapTodoUpdatedToState(event);
    }
  }

  Stream<HomeState> _mapTodosLoadedToState() async* {
    try {
      final todos = await this.todoRepository.loadTodos();
      yield HomeLoadSuccess(
        todos,
      );
    } catch (_) {
      yield HomeLoadFailure();
    }
  }

  Stream<HomeState> _mapTodoUpdatedToState(HomeUpdated event) async* {
    if (state is HomeLoadSuccess) {
      final List<Todo> updatedTodos =
          (state as HomeLoadSuccess).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      yield HomeLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todoRepository.saveTodos(todos);
  }
}
