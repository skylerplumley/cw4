import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(scaffoldBackgroundColor: Colors.pink[50]),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> tasklist = [];
  TextEditingController taskinput = TextEditingController();
  DateTime date = DateTime.now();

  void createtask(String task, String descript, DateTime date) {
    setState(() {
      tasklist.add({
        'task': taskinput.text,
        'description': descript,
        'date': date,
        'completed': false
      });
      taskinput.clear();
    });
  }

  void deletetask(int index) {
    setState(() {
      tasklist.removeAt(index);
    });
  }

  void completedtask(int index) {
    setState(() {
      tasklist[index]['completed'] = !tasklist[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime(2025, 3, 6, 0, 0),
            firstDay: DateTime(2025, 3, 1, 0, 0),
            lastDay: DateTime(2025, 3, 31, 0, 0),
          ),
          TextField(
            controller: taskinput,
            decoration: InputDecoration(hintText: 'Enter task'),
          ),
          SizedBox(height: 16),
          //ElevatedButton(onPressed: createtask, child: Text('Add')),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
                itemCount: tasklist.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: tasklist[index]['completed'],
                        onChanged: (_) => completedtask(index),
                      ),
                      Expanded(
                        child: Text(tasklist[index]['task']),
                      ),
                      TextButton(
                        onPressed: () => deletetask(index),
                        child: Text('Delete'),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
