import 'package:todo_app_bloc/model/todo_model.dart';
import 'package:todo_app_bloc/repository/src/file_storage.dart';
import 'package:todo_app_bloc/repository/src/web_client.dart';

class TodoRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const TodoRepository({
    required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<Todo>> loadTodos() async {
    try {
      return await fileStorage.loadTodos();
    } catch (e) {
      final todos = await webClient.fetchTodos();

      fileStorage.saveTodos(todos);

      return todos;
    }
  }

  // Persists todos to local disk and the web
  Future saveTodos(List<Todo> todos) {
    return Future.wait<dynamic>([
      fileStorage.saveTodos(todos),
      webClient.postTodos(todos),
    ]);
  }
}
