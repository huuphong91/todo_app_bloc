part of 'incomplete_todo_cubit.dart';

abstract class IncompleteTodoState extends Equatable {
  const IncompleteTodoState();

  @override
  List<Object> get props => [];
}

class IncompleteTodoLoadInProgress extends IncompleteTodoState {}

class IncompleteTodoLoadSuccess extends IncompleteTodoState {
  final List<Todo> allTodos;

  const IncompleteTodoLoadSuccess(this.allTodos);

  @override
  List<Object> get props => [allTodos];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $allTodos }';
  }
}
