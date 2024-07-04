import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nubiatech_todo_app/store/task_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NubiaTech To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TaskStore _taskStore = TaskStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To-Do List'),
      ),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: _taskStore.tasks.length,
          itemBuilder: (context, index) {
            final task = _taskStore.tasks[index];
            return ListTile(
              title: Text(
                task.description,
                style: TextStyle(
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  task.isDone = value!;
                  _taskStore.updateTask(task);
                },
              ),
              onLongPress: () => _taskStore.deleteTask(task.id!),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _displayDialog(BuildContext context) async {
    final TextEditingController _textFieldController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new task'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: 'Enter task description'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _taskStore.addTask(_textFieldController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
