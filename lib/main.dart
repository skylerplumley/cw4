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
        'task': task,
        'description': descript,
        'date': date,
        'completed': false
      });
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

  void createplan() {
    TextEditingController name = TextEditingController();
    TextEditingController descript = TextEditingController();
    DateTime date = DateTime.now();

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(),
          child: Column(
            children: [
              TextField(
                  controller: name,
                  decoration: InputDecoration(hintText: 'Plan name')),
              TextField(
                  controller: descript,
                  decoration: InputDecoration(hintText: 'Description')),
              SizedBox(height: 8),
              TableCalendar(
                  firstDay: DateTime(2025, 3, 1, 0, 0),
                  lastDay: DateTime(2025, 3, 31, 0, 0),
                  focusedDay: date,
                  selectedDayPredicate: (day) => isSameDay(date, day),
                  onDaySelected: (selected, focusedDay) {
                    setState(() {
                      date = focusedDay;
                    });
                  }),
              ElevatedButton(
                onPressed: () => createtask(name.text, descript.text, date),
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void edittask(int index) {
    taskinput.text = tasklist[index]['task'];
    createplan();
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
            focusedDay: date,
            firstDay: DateTime(2025, 3, 1, 0, 0),
            lastDay: DateTime(2025, 3, 31, 0, 0),
          ),
          ElevatedButton(
            onPressed: createplan,
            child: Text('Create Plan'),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: tasklist.length,
              itemBuilder: (context, index) {
                final task = tasklist[index];
                return GestureDetector(
                  onDoubleTap: () => deletetask(index),
                  onHorizontalDragEnd: (_) => completedtask(index),
                  onLongPress: () => edittask(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: task['completed'] ? Colors.green : Colors.red,
                    ),
                    child: Row(
                      children: [
                        Text(
                            "Plan:  ${task['task']}\nDescription:  ${task['description']}\nDate:  ${task['date']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
