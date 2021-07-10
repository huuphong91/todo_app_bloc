part of 'all_todo_cubit.dart';

abstract class AllTodoState extends Equatable {
  const AllTodoState();

  @override
  List<Object> get props => [];
}

class AllTodoLoadInProgress extends AllTodoState {}

class AllTodoLoadSuccess extends AllTodoState {
  final List<Todo> allTodos;

  const AllTodoLoadSuccess(this.allTodos);

  @override
  List<Object> get props => [allTodos];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $allTodos }';
  }
}
