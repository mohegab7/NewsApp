import 'package:flutter/material.dart';
import 'package:flutter_application_1/moduels/todo_app/archive_task/archive_tasks.dart';
import 'package:flutter_application_1/moduels/todo_app/done_tasks/done_tasks.dart';
import 'package:flutter_application_1/moduels/todo_app/new_task/new_tasks.dart';

import 'package:flutter_application_1/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
// ignore: unnecessary_import
import 'package:sqflite/sqlite_api.dart';

class Home_layout extends StatefulWidget {
  @override
  State<Home_layout> createState() => _Home_layoutState();
}

class _Home_layoutState extends State<Home_layout> {
  int current_index = 0;
  late Database database;
  var formkey = GlobalKey<FormState>();
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  bool isbottomsheetShown = false;
  IconData fabicon = Icons.edit;
  var titleControll = TextEditingController();
  var timeControll = TextEditingController();
  var dateControll = TextEditingController();
  List<Map> tasks = [];

  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];
  List<String> titles = [
    'NewTasks',
    'DoneTasks',
    'ArchiveTasks',
  ];

  @override
  void initState() {
    super.initState();
    createdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          titles[current_index],
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      body: screens[current_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isbottomsheetShown) {
            if (formkey.currentState!.validate()) {
              insertdatabase(
                title: titleControll.text,
                time: timeControll.text,
                date: dateControll.text,
              ).then((value) {
                Navigator.pop(context);
                isbottomsheetShown = false;
                setState(() {
                  fabicon = Icons.edit;
                });
              });
            }
          } else {
            Scaffoldkey.currentState
                ?.showBottomSheet(
                  (context) => Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                            controller: titleControll,
                            type: TextInputType.text,
                            hint: 'task title',
                            prefix: Icons.title,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'title is empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                            controller: timeControll,
                            type: TextInputType.datetime,
                            hint: 'time',
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                timeControll.text =
                                    value!.format(context).toString();
                                print(value.format(context));
                              });
                            },
                            prefix: Icons.watch_later_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'time is empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                            controller: dateControll,
                            type: TextInputType.datetime,
                            hint: 'date',
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025, 8, 22),
                              ).then((value) {
                                dateControll.text =
                                    DateFormat.yMMMd().format(value!);
                              });
                            },
                            prefix: Icons.calendar_today,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'date is empty';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 20.0,
                )
                .closed
                .then((value) {
              isbottomsheetShown = false;
              setState(() {
                fabicon = Icons.edit;
              });
            });
            isbottomsheetShown = true;
            setState(() {
              fabicon = Icons.add;
            });
          }
        },
        child: Icon(fabicon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: current_index,
        onTap: (index) {
          setState(() {
            current_index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'TASKS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'archived',
          ),
        ],
      ),
    );
  }

  // Future<String> getname() async {
  //   return 'mohamed';
  // }

  void createdatabase() async {
    database = await openDatabase(
      'todo.dp',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        // getdatabase(database);
        // getdatabase().then((value) {
        //   tasks = value;
        //   print(tasks);
        // });
        print('database opend');
      },
    );
  }

  Future insertdatabase({
    required String title,
    required String time,
    required String date,
  }) {
    return database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT TABLE tasks(title,date,time,status) VALUES("$title","$date","$time","new")',
      )
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('error when inserted ${error}');
      });
    });
  }

  // Future<List<Map>> getdatabase(Database database) async {
  //   return await database.rawQuery('SELECT * FROM tasks');
  // }
}
