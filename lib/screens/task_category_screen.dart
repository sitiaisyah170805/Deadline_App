import 'package:flutter/material.dart';

class TaskCategoryScreen extends StatefulWidget {
  final String title;

  const TaskCategoryScreen({super.key, required this.title});
  @override
  State<TaskCategoryScreen> createState() => _TaskCategoryScreenState(); 
    
}

class _TaskCategoryScreenState extends State<TaskCategoryScreen> {
  List<String> tasks = [];

  void _addTask(String task) {
    setState(() {
      tasks.add(task);
    });
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
                _addTask(controller.text);
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
      body: tasks.isEmpty
          ? const Center(child: Text("Belum ada tugas"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.assignment, color: Colors.teal),
                    title: Text(tasks[index]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.teal[800],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}