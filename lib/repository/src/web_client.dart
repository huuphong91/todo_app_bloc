import 'package:todo_app_bloc/model/todo_model.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  Future<List<Todo>> fetchTodos() async {
    return Future.delayed(
        delay,
        () => [
              Todo(
                note: 'Buy food for da kitty',
                id: '1',
              ),
              Todo(
                note: 'Find a Red Sea dive trip',
                id: '2',
              ),
              Todo(
                note: 'Book flights to Egypt',
                id: '3',
                complete: true,
              ),
              Todo(
                note: 'Decide on accommodation',
                id: '4',
              ),
              Todo(
                note: 'Sip Margaritas',
                id: '5',
                complete: true,
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postTodos(List<Todo> todos) async {
    return Future.value(true);
  }
}
