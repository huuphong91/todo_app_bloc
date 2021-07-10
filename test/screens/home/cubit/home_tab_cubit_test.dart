import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_bloc/screens/home/cubit/cubits.dart';

void main() {
  group('HomeTabCubit', () {
    late HomeTabCubit homeTabCubit;

    setUp(() {
      homeTabCubit = HomeTabCubit();
    });

    test('initial state is 0', () {
      expect(homeTabCubit.state, 0);
    });

    blocTest(
      'value shouble be [1] when calling update(1)',
      build: () => homeTabCubit,
      act: (bloc) => (bloc as HomeTabCubit).update(1),
      expect: () => [1],
    );
  });
}
