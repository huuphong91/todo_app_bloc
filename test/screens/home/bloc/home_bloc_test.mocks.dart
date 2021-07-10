// Mocks generated by Mockito 5.0.10 from annotations
// in todo_app_bloc/test/screens/home/bloc/home_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_app_bloc/model/todo_model.dart' as _i6;
import 'package:todo_app_bloc/repository/src/file_storage.dart' as _i2;
import 'package:todo_app_bloc/repository/src/web_client.dart' as _i3;
import 'package:todo_app_bloc/repository/todo_repository.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeFileStorage extends _i1.Fake implements _i2.FileStorage {}

class _FakeWebClient extends _i1.Fake implements _i3.WebClient {}

/// A class which mocks [TodoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRepository extends _i1.Mock implements _i4.TodoRepository {
  MockTodoRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FileStorage get fileStorage =>
      (super.noSuchMethod(Invocation.getter(#fileStorage),
          returnValue: _FakeFileStorage()) as _i2.FileStorage);
  @override
  _i3.WebClient get webClient =>
      (super.noSuchMethod(Invocation.getter(#webClient),
          returnValue: _FakeWebClient()) as _i3.WebClient);
  @override
  _i5.Future<List<_i6.Todo>> loadTodos() =>
      (super.noSuchMethod(Invocation.method(#loadTodos, []),
              returnValue: Future<List<_i6.Todo>>.value(<_i6.Todo>[]))
          as _i5.Future<List<_i6.Todo>>);
  @override
  _i5.Future<dynamic> saveTodos(List<_i6.Todo>? todos) =>
      (super.noSuchMethod(Invocation.method(#saveTodos, [todos]),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
}
