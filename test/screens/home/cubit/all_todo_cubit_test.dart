import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/repository/todo_repository.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';
import 'package:todo_app_bloc/screens/home/cubit/cubits.dart';

import 'all_todo_cubit_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  group('AllToDoCutbit', () {
    late HomeBloc homeBloc;
    late AllTodoCubit allTodoCubit;
    late MockTodoRepository todoRepository;

    setUp(() {
      todoRepository = MockTodoRepository();
      homeBloc = HomeBloc(todoRepository: todoRepository);
      allTodoCubit = AllTodoCubit(homeBloc: homeBloc);
    });

    tearDown(() {
      homeBloc.close();
      allTodoCubit.close();
    });

    test('initial state is AllTodoLoadInProgress', () {
      expect(allTodoCubit.state, AllTodoLoadInProgress());
    });

    blocTest(
      'emits AllTodoLoadSuccess when homeBloc add HomeLoaded event',
      build: () {
        when(todoRepository.loadTodos()).thenAnswer((_) async => [
              Todo(id: '1', note: '1', complete: true),
            ]);
        homeBloc.add(HomeLoaded());
        return allTodoCubit;
      },
      expect: () => [
        AllTodoLoadSuccess([
          Todo(id: '1', note: '1', complete: true),
        ])
      ],
    );
  });
}
