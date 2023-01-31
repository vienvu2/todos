import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Todo {
  int id = 0;
  String title = '';
  String description = '';
  String type = '';
  String attachment = '';
  bool isChild = false;
  double time = 0;
  double realTime = 0;
  bool done = false;
  DateTime endAt = DateTime.now();
  DateTime startAt = DateTime.now();

  get startAtString => '2023-01-01 20:00';
  get endAtString => '2023-01-01 20:00';

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'title': title,
      'description': description,
      'time': time,
      'type': type,
      'done': done == true ? 1 : 0,
      'startAt': startAt.toString(),
      'endAt': endAt.toString(),
      'parentId': null
    };
    return map;
  }

  Todo();

  Todo.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? 0;
    title = map['title'] ?? '';
    time = map['time'] ?? 0.0;
    type = map['type'] ?? '';
    description = map['description'] ?? '';
  }
}

class TodoProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          create table todo ( 
            id integer primary key autoincrement, 
            title text not null,
            type text,
            description text,
            time double not null,
            endAt text ,
            startAt text not null,
            done integer not null,
            parentId integer
          )
      ''');
      },
    );
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert('todo', todo.toMap());
    return todo;
  }

  Future<List<Todo>> getTodoList(int page, int limit) async {
    List<Map<String, dynamic>> maps = await db.query('todo', columns: [
      'id',
      'done',
      'title',
      'time',
      'description',
      'parentId',
      'type'
    ], whereArgs: [
      page
    ]);

    print(maps);

    return maps.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    return await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future close() async => db.close();
}
