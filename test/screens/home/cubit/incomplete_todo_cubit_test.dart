import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/repository/todo_repository.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';
import 'package:todo_app_bloc/screens/home/cubit/cubits.dart';

import 'incomplete_todo_cubit_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  group('IncompleteToDoCutbit', () {
    late HomeBloc homeBloc;
    late IncompleteTodoCubit incompleteTodoCubit;
    late MockTodoRepository todoRepository;

    setUp(() {
      todoRepository = MockTodoRepository();
      homeBloc = HomeBloc(todoRepository: todoRepository);
      incompleteTodoCubit = IncompleteTodoCubit(homeBloc: homeBloc);
    });

    tearDown(() {
      homeBloc.close();
      incompleteTodoCubit.close();
    });

    test('initial state is IncompleteTodoLoadInProgress', () {
      expect(incompleteTodoCubit.state, IncompleteTodoLoadInProgress());
    });

    blocTest(
      'emits IncompleteTodoLoadSuccess when homeBloc add HomeLoaded event',
      build: () {
        when(todoRepository.loadTodos()).thenAnswer((_) async => [
              Todo(id: '1', note: '1', complete: true),
              Todo(id: '2', note: '2', complete: true),
              Todo(id: '3', note: '3', complete: false),
            ]);
        homeBloc.add(HomeLoaded());
        return incompleteTodoCubit;
      },
      expect: () => [
        IncompleteTodoLoadSuccess([
          Todo(id: '3', note: '3', complete: false),
        ])
      ],
    );

    blocTest(
      'emits IncompleteTodoLoadSuccess when todo checked button updated',
      build: () {
        when(todoRepository.loadTodos()).thenAnswer((_) async => [
              Todo(id: '1', note: '1', complete: true),
              Todo(id: '2', note: '2', complete: true),
              Todo(id: '3', note: '3', complete: false),
            ]);
        when(todoRepository.saveTodos([
          Todo(id: '1', note: '1', complete: false),
          Todo(id: '2', note: '2', complete: true),
          Todo(id: '3', note: '3', complete: false),
        ])).thenAnswer((_) async => 'Stub');
        homeBloc
          ..add(HomeLoaded())
          ..add(HomeUpdated(
            Todo(id: '1', note: '1', complete: false),
          ));
        return incompleteTodoCubit;
      },
      skip: 1,
      expect: () => [
        IncompleteTodoLoadSuccess([
          Todo(id: '1', note: '1', complete: false),
          Todo(id: '3', note: '3', complete: false),
        ])
      ],
    );
  });
}
