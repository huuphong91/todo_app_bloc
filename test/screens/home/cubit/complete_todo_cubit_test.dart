import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/repository/todo_repository.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';
import 'package:todo_app_bloc/screens/home/cubit/complete_todo_cubit.dart';

import 'complete_todo_cubit_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  group('CompleteToDoCutbit', () {
    late HomeBloc homeBloc;
    late CompleteTodoCubit completeTodoCubit;
    late MockTodoRepository todoRepository;

    setUp(() {
      todoRepository = MockTodoRepository();
      homeBloc = HomeBloc(todoRepository: todoRepository);
      completeTodoCubit = CompleteTodoCubit(homeBloc: homeBloc);
    });

    tearDown(() {
      homeBloc.close();
      completeTodoCubit.close();
    });

    test('initial state is CompleteTodoLoadInProgress', () {
      expect(completeTodoCubit.state, CompleteTodoLoadInProgress());
    });

    blocTest(
      'emits CompleteTodoLoadSuccess when homeBloc add HomeLoaded event',
      build: () {
        when(todoRepository.loadTodos()).thenAnswer((_) async => [
              Todo(id: '1', note: '1', complete: true),
              Todo(id: '2', note: '2', complete: true),
              Todo(id: '3', note: '3', complete: false),
            ]);
        homeBloc.add(HomeLoaded());
        return completeTodoCubit;
      },
      expect: () => [
        CompleteTodoLoadSuccess([
          Todo(id: '1', note: '1', complete: true),
          Todo(id: '2', note: '2', complete: true),
        ])
      ],
    );

    blocTest(
      'emits CompleteTodoLoadSuccess when todo checked button updated',
      build: () {
        when(todoRepository.loadTodos()).thenAnswer((_) async => [
              Todo(id: '1', note: '1', complete: true),
              Todo(id: '2', note: '2', complete: true),
              Todo(id: '3', note: '3', complete: false),
            ]);
        when(todoRepository.saveTodos([
          Todo(id: '1', note: '1', complete: true),
          Todo(id: '2', note: '2', complete: false),
          Todo(id: '3', note: '3', complete: false),
        ])).thenAnswer((_) async => 'Stub');
        homeBloc
          ..add(HomeLoaded())
          ..add(HomeUpdated(
            Todo(id: '2', note: '2', complete: false),
          ));
        return completeTodoCubit;
      },
      skip: 1,
      expect: () => [
        CompleteTodoLoadSuccess([
          Todo(id: '1', note: '1', complete: true),
        ])
      ],
    );
  });
}
