part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoadInProgress extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<Todo> todos;

  const HomeLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

class HomeLoadFailure extends HomeState {}
