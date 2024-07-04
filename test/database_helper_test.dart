import 'package:flutter_test/flutter_test.dart';
import 'package:nubiatech_todo_app/data_source/database_helper.dart';
import 'package:nubiatech_todo_app/models/task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUpAll(() async {
    // Initialize sqflite for testing with ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    databaseHelper = DatabaseHelper();
    await databaseHelper.database; // Ensure the database is initialized
  });

  tearDownAll(() async {
    // Close the database after all tests are done
    final db = await databaseHelper.database;
    await db.close();
  });

  setUp(() async {
    // Clear the database before each test
    final db = await databaseHelper.database;
    await db.delete('tasks');
  });

  test('insertTask should insert a task into the database', () async {
    // Arrange
    final task = Task(description: 'Test Task', isDone: false);
    final db = await databaseHelper.database;

    // Act
    final id = await databaseHelper.insertTask(task);

    // Assert
    expect(id, isNonZero);
    final tasks = await db.query('tasks');
    expect(tasks.length, 1);
    expect(tasks.first['description'], 'Test Task');
  });

  test('getTasks should retrieve tasks from the database', () async {
    // Arrange
    final task = Task(description: 'Test Task', isDone: false);
    await databaseHelper.insertTask(task);

    // Act
    final tasks = await databaseHelper.getTasks();

    // Assert
    expect(tasks.length, 1);
    expect(tasks.first.description, 'Test Task');
  });

  test('updateTask should update a task in the database', () async {
    // Arrange
    final task = Task(description: 'Test Task', isDone: false);
    final taskId = await databaseHelper.insertTask(task);
    final updatedTask =
        Task(id: taskId, description: 'Updated Task', isDone: true);

    // Act
    final rowsAffected = await databaseHelper.updateTask(updatedTask);

    // Assert
    expect(rowsAffected, 1);
    final tasks = await databaseHelper.getTasks();
    expect(tasks.first.description, 'Updated Task');
    expect(tasks.first.isDone, true);
  });

  test('deleteTask should remove a task from the database', () async {
    // Arrange
    final task = Task(description: 'Test Task', isDone: false);
    final taskId = await databaseHelper.insertTask(task);

    // Act
    final rowsAffected = await databaseHelper.deleteTask(taskId);

    // Assert
    expect(rowsAffected, 1);
    final tasks = await databaseHelper.getTasks();
    expect(tasks.isEmpty, true);
  });
}
