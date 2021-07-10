part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeEvent {}

class HomeUpdated extends HomeEvent {
  final Todo todo;

  const HomeUpdated(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoUpdated { updatedTodo: $todo }';
}
