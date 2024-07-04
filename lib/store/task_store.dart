import 'package:mobx/mobx.dart';
import 'package:nubiatech_todo_app/data_source/database_helper.dart';
import 'package:nubiatech_todo_app/models/task.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  Future<void> fetchTasks() async {
    tasks.clear();
    tasks.addAll(await _dbHelper.getTasks());
  }

  @action
  Future<void> addTask(String description) async {
    final task = Task(id: 0, description: description);
    await _dbHelper.insertTask(task);
    await fetchTasks();
  }

  @action
  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    await fetchTasks();
  }

  @action
  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    await fetchTasks();
  }
}
