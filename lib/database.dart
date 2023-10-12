  import 'package:sqflite/sqflite.dart';
  import 'package:todo/tasks.dart';
  import 'package:path/path.dart';


  class DatabaseHelper {
    late Database database;

    Future<void> initializeDatabase() async {
      final path = join(await getDatabasesPath(), 'tasks.db'); // Use join here
      database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          return db.execute('''
            CREATE TABLE tasks (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT
            )
          ''');
        },
      );
    }

    Future<int> insertTask(Task task) async {
      return await database.insert('tasks', task.toMap());
    }

    Future<List<Task>> getTasks() async {
      final List<Map<String, dynamic>> taskMaps = await database.query('tasks');
      return List.generate(taskMaps.length, (index) {
        return Task(
          id: taskMaps[index]['id'],
          title: taskMaps[index]['title'],
          description: taskMaps[index]['description'],
        );
      });
    }

    Future<int> deleteTask(int id) async {
      return await database.delete('tasks', where: 'id = ?', whereArgs: [id]);
    }
  }
