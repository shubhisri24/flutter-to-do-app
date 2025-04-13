class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Check email', isDone: true),
      ToDo(id: '02', todoText: 'Morning walk', isDone: false),
      ToDo(id: '03', todoText: 'Flutter practice', isDone: false),
      ToDo(id: '04', todoText: 'Read a book', isDone: false),
    ];
  }
}
