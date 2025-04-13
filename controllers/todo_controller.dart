import '../model/todo.dart';

class TodoController {
  List<ToDo> todos = ToDo.todoList();

  void addTodo(String text) {
    if (text.trim().isEmpty) return;
    todos.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: text.trim(),
    ));
  }

  void deleteTodo(ToDo todo) {
    todos.remove(todo);
  }

  void toggleTodo(ToDo todo) {
    todo.isDone = !todo.isDone;
  }

  void clearTodos() {
    todos.clear();
  }
}
