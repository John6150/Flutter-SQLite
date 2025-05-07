import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlflite_class/controllers.dart';
import 'package:sqlflite_class/database.dart';
import 'package:sqlflite_class/student_model.dart';
import 'package:sqlflite_class/widgets.dart';

Future<void> main() async {
  runApp(const MyApp());
  // Initialize FFI
  // sqfliteFfiInit();

  // Set the global factory for `openDatabase`
  // var databaseFactory = databaseFactoryFfi;

  // Ensure directory exists
  // final dbPath = join(Directory.current.path, 'data');
  // await Directory(dbPath).create(recursive: true); // Ensure the directory exists
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter SQFLite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _course;
  List allStud = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List> getAllData() async {
    allStud.clear();
    List<StudentModel>? res = await DataBase.getAllNote();
    for (var i = 0; i < res!.length; i++) {
      allStud.add(res[i]);
    }
    return allStud;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              InputFieldWidget(
                name: 'Name',
                sample: 'John Doe',
                control: nameController,
              ),
              SizedBox(height: 30),
              InputFieldWidget(
                name: 'ID',
                sample: '15/67EC/616',
                control: courseController,
              ),
              SizedBox(height: 30),
              DropDownWidget(
                title: 'Course',
                dropDown: [
                  DropdownMenuItem(value: '', child: Text('Course')),
                  DropdownMenuItem(value: 'HTML/CSS', child: Text('HTML/CSS')),
                  DropdownMenuItem(value: 'NodeJs', child: Text('NodeJs')),
                  DropdownMenuItem(
                    value: 'JavaScript',
                    child: Text('JavaScript'),
                  ),
                  DropdownMenuItem(
                    value: 'Flutter/Dart',
                    child: Text('Flutter Dart'),
                  ),
                ],
              ),
              SizedBox(height: 50),

              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 207, 153, 216),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FutureBuilder(
                    future: getAllData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasData) {
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: 600,
                            child: Column(
                              children: [
                                ...allStud.map(
                                  (e) => Column(
                                    children: [
                                      Card(
                                        margin: EdgeInsets.all(7),
                                        shape: Border.all(color: Colors.grey),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.account_circle),
                                                  SizedBox(width: 20),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(e.name),
                                                      SizedBox(height: 5),
                                                      Text('${e.studentID}'),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(e.course),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          !snapshot.hasData) {
                        return Center(child: Text('Sorry, no data to display'));
                      } else {
                        return Center(child: Text('Sorry, an error Occured'));
                      }
                    },
                    // child:
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name = nameController.text;
          final _id = courseController.text;
          // ignore: avoid_print
          // print(course);
          if (name.isEmpty || _id.isEmpty || course == null) {
            return;
          } else {
            final StudentModel student = StudentModel(
              name: name,
              studentID: _id,
              course: course!,
            );
            await DataBase.addNote(student);
            await getAllData();
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
