part of 'complete_todo_cubit.dart';

abstract class CompleteTodoState extends Equatable {
  const CompleteTodoState();

  @override
  List<Object> get props => [];
}

class CompleteTodoLoadInProgress extends CompleteTodoState {}

class CompleteTodoLoadSuccess extends CompleteTodoState {
  final List<Todo> allTodos;

  const CompleteTodoLoadSuccess(this.allTodos);

  @override
  List<Object> get props => [allTodos];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $allTodos }';
  }
}
