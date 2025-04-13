import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';
import '../controllers/theme_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDo> todosList = ToDo.todoList();
  List<ToDo> filteredTodosList = [];
  TextEditingController _todoController = TextEditingController();
  TextEditingController _searchController =
      TextEditingController(); // Controller for search bar

  @override
  void initState() {
    super.initState();
    filteredTodosList = todosList;
    _searchController.addListener(() {
      _filterTodos();
    });
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      // Sort the list after the change
      todosList.sort((a, b) => a.isDone
          ? 1
          : b.isDone
              ? -1
              : 0); // Move completed tasks to the bottom
      filteredTodosList =
          List.from(todosList); // Reapply search filter after sorting
    });
  }

  void _deleteToDo(ToDo todo) {
    setState(() {
      todosList.remove(todo);
      filteredTodosList =
          List.from(todosList); // Reapply search filter after deleting
    });
  }

  // Add ToDo functionality
  void _addToDo() {
    if (_todoController.text.isNotEmpty) {
      setState(() {
        todosList.add(ToDo(
          id: DateTime.now().toString(),
          todoText: _todoController.text,
        ));
        // Sort after adding a new task
        todosList.sort((a, b) => a.isDone
            ? 1
            : b.isDone
                ? -1
                : 0);
        filteredTodosList =
            List.from(todosList); // Reapply search filter after adding
      });
      _todoController.clear(); // Clear input field after adding
    }
  }

  // Filter ToDos based on search text
  void _filterTodos() {
    setState(() {
      filteredTodosList = todosList.where((todo) {
        return todo.todoText!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.menu, size: 40),
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xffec457c),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => themeController.toggle(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController, // Search field
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: const Text(
                          "To-Dos",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ✅ Loop through filteredTodosList and render them
                      for (ToDo todo in filteredTodosList)
                        ToDoItem(
                          todo: todo,
                          onTap: () => _handleToDoChange(todo),
                          onDelete: () => _deleteToDo(todo),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                children: [
                  // TextField Container
                  Expanded(
                    child: Container(
                      height: 56, // match button height
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintText: 'Add new todo items',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Circular ElevatedButton
                  Container(
                    height: 56,
                    width: 56,
                    child: ElevatedButton(
                      onPressed:
                          _addToDo, // Call _addToDo method on button press
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.deepPurple, // customize color
                        elevation: 4,
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
