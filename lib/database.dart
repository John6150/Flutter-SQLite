import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlflite_class/student_model.dart';

class DataBase {
  static const int version = 1;
  static const String databasename = 'Student_DB.db';

  // Create a Database first time your App runs
  static Future<Database> getDB() async {
    // print('initializing');
    Database database = await openDatabase(
      join(await getDatabasesPath(), databasename),
      onCreate: (db, version) async {
        print('creating');
        await db.execute(
          'CREATE TABLE StudentDB (id INTEGER PRIMARY KEY, studentID TEXT , name TEXT, course TEXT)',
        );
      },
      version: version,
    );
    return database;
  }

  // To insert data into the Database titled: StudentDB, this function is called
  static Future<int> addNote(StudentModel studentData) async {
    // Calling and waiting for the database
    final db = await getDB();

    // Querying the database
    return await db.insert(
      // This is the name of the table/ DataBase
      "StudentDB",

      //this calls the toJson method that converts the Map into Json format
      studentData.toJson(),
      // {
      //   'name': 'john',
      //   'studentID': '',
      //   'course': 'NodeJs'
      // },

      //ConflictAlgorithm.replace ensures that if a row with the same id already exists, it will be replaced.
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // To Update a field in the Database titled: StudentDB, this function is called
  static Future<int> updateNote(StudentModel studentData) async {
    // Call and wait for the database
    final db = await getDB();

    // Querying the database
    return await db.update(
      "StudentDB",
      studentData.toJson(),

      // ? is a placeholder, and whereArgs provides the actual value safely (helps prevent SQL injection).
      where: "id = ?",

      // 15/67EC/616

      // This retrieves rows where id is equal to studentData.id
      whereArgs: [studentData.studentID],

      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // To Delete a field in the Database titled: StudentDB, this function is called
  static Future<int> deleteNote(StudentModel studentData) async {
    final db = await getDB();

    return await db.delete(
      "StudentDB",

      // ? is a placeholder, and whereArgs provides the actual value safely (helps prevent SQL injection).
      where: "id = ?",

      // This retrieves rows where id is equal to studentData.id
      whereArgs: [studentData.studentID],
    );
  }

  // To Get all the fields in the Database titled: StudentDB, this function is called
  static Future<List<StudentModel>?> getAllNote() async {
    final db = await getDB();

    List<Map<String, dynamic>> database = await db.query("StudentDB");

    if (database.isNotEmpty) {
      print(database);
      List<StudentModel> res =
          database.map((e) => StudentModel.fromJson(e)).toList();
      return res;
    } else {
      return null;
    }
  }
}
