// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];
  TextEditingController _taskController = TextEditingController();

  void _addTask() {
    String taskText = _taskController.text.trim();
    if (taskText.isNotEmpty) {
      setState(() {
        tasks.add(Task(text: taskText, isCompleted: false));
        _taskController.clear();
      });
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Todo"),
      ),
      body: ListView(
        children: [
          TextField(
            controller: _taskController,
            decoration: const InputDecoration(
              hintText: 'Enter a task',
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: const Text('Add Task'),
          ),
          for (int i = 0; i < tasks.length; i++)
            ListTile(
              onTap: () => _toggleTaskCompletion(i),
              leading: Checkbox(
                value: tasks[i].isCompleted,
                onChanged: (bool? value) {
                  _toggleTaskCompletion(i);
                },
              ),
              title: Text(
                tasks[i].text,
                style: tasks[i].isCompleted
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Task {
  final String text;
  bool isCompleted;

  Task({required this.text, required this.isCompleted});
}
