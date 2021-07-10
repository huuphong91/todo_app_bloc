import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/repository/todo_repository.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockTodoRepository todoRepository;

    setUp(() {
      todoRepository = MockTodoRepository();
      homeBloc = HomeBloc(todoRepository: todoRepository);
    });

    tearDown(() {
      homeBloc.close();
    });

    test('initial state is HomeLoadInProgress', () {
      expect(homeBloc.state, HomeLoadInProgress());
    });

    blocTest(
      'emits HomeLoadSuccess when todoRepository returns todos list',
      build: () {
        when(todoRepository.loadTodos()).thenAnswer((_) async => []);
        return homeBloc;
      },
      skip: 0,
      act: (bloc) => (bloc as HomeBloc).add(HomeLoaded()),
      expect: () => [
        HomeLoadSuccess([]),
      ],
    );

    blocTest(
      'emits HomeLoadSuccess when todo checked updated',
      build: () {
        when(todoRepository.loadTodos()).thenAnswer((_) async => [
              Todo(id: '1', note: '1', complete: true),
            ]);
        when(todoRepository.saveTodos([
          Todo(id: '1', note: '1', complete: false),
        ])).thenAnswer((_) async => 'Stub');
        return homeBloc;
      },
      act: (bloc) => (bloc as HomeBloc)
        ..add(HomeLoaded())
        ..add(HomeUpdated(Todo(id: '1', note: '1', complete: false))),
      expect: () => [
        HomeLoadSuccess([Todo(id: '1', note: '1', complete: true)]),
        HomeLoadSuccess([Todo(id: '1', note: '1', complete: false)]),
      ],
    );

    blocTest(
      'emits HomeLoadFailure when todoRepository throws error',
      build: () {
        when(todoRepository.loadTodos()).thenThrow('Error');
        return homeBloc;
      },
      skip: 0,
      act: (bloc) => (bloc as HomeBloc).add(HomeLoaded()),
      expect: () => [
        HomeLoadFailure(),
      ],
    );
  });
}
