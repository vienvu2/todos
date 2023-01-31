import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

const String tableTodo = 'todo';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnDescription = 'description';
const String columnDone = 'done';

class Todo {
  int id = 0;
  String title = '';
  String description = '';
  String attachment = '';
  bool isChild = false;
  int time = 0;
  int realTime = 0;
  bool done = false;
  String startAtString = '';
  String endAtString = '';
  DateTime endAt = DateTime.now();
  DateTime startAt = DateTime.now();

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      columnDescription: description,
      columnDone: done == true ? 1 : 0
    };
    return map;
  }

  Todo();

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId] ?? 0;
    title = map[columnTitle] ?? '';
    description = map[columnDescription] ?? '';
  }
}

class TodoProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableTodo ( 
            $columnId integer primary key autoincrement, 
            $columnTitle text not null,
            $columnDescription text not null,
            $columnDone integer not null)
      ''');
    });
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo?> getTodo(int id) async {
    List<Map<String, dynamic>> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Todo>> getTodoList(int page, int limit) async {
    List<Map<String, dynamic>> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle, columnDescription],
        whereArgs: [page]);

    return maps.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
