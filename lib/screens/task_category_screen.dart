import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskCategoryScreen extends StatefulWidget {
  final String title;

  const TaskCategoryScreen({super.key, required this.title});
  @override
  State<TaskCategoryScreen> createState() => _TaskCategoryScreenState(); 
    
}

class _TaskCategoryScreenState extends State<TaskCategoryScreen> {
  // final Box box = Hive.box('tasksBox');
  late final Box box;

  void initState() {
    super.initState();

    switch (widget.title) {
    case "Homework":
      box = Hive.box('homeworkBox');
      break;
    case "Activity":
      box = Hive.box('activityBox');
      break;
    case "Habit":
      box = Hive.box('habitBox');
      break;
    case "Goal":
      box = Hive.box('goalBox');
      break;
    default:
      box = Hive.box('homeworkBox');
  }
  }

  

  void _showAddDialog() {
    TextEditingController controller =TextEditingController();
    showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Tambah ${widget.title}"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "masukkan tugas. . .",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                box.add(controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text("Tambah"),
          ),
        ],
      );
      },
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {

          if (box.isEmpty) {
            return const Center(child: Text("belum ada tugas"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index);

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(Icons.assignment, color: Colors.teal),
                  title: Text(task),
                ),
              );
            }
          );
        }
      ),
      // body: tasks.isEmpty
      //     ? const Center(child: Text("Belum ada tugas"))
      //     : ListView.builder(
      //         padding: const EdgeInsets.all(16),
      //         itemCount: tasks.length,
      //         itemBuilder: (context, index) {
      //           return Card(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15),
      //             ),
      //             child: ListTile(
      //               leading: const Icon(Icons.assignment, color: Colors.teal),
      //               title: Text(tasks[index]),
      //             ),
      //           );
      //         },
      //       ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.teal[800],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}