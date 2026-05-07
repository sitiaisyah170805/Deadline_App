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
  DateTime selectedDate = DateTime.now();

  final ScrollController _scrollController =ScrollController();

  String _getDayName(DateTime date) {
    List days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return days[date.weekday - 1];
  }

  @override
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
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollController.jumpTo(15 * 86.0);
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
                // box.add(controller.text);
                box.add({
                  "title": controller.text,
                  "done": false,
                });
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
 // Date Horizontal
      body: Column(
        children: [

          SizedBox(
            height: 95,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 30,
              itemBuilder: (context, index) {
                DateTime date =DateTime.now().add(Duration(days: index - 15));

                bool isToday =
                date.day == DateTime.now().day &&
                date.month == DateTime.now().month &&
                date.year == DateTime.now().year;

                bool isSelected =
                date.day == selectedDate.day &&
                date.month == selectedDate.month &&
                date.year == selectedDate.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                      ? Colors.purple.shade100
                      : isToday
                      ?Colors.teal: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayName(date),
                          style: TextStyle(
                            color:isSelected || isToday
                            ? Colors.white
                            : Colors.black54,
                          ),
                        ),
                        const SizedBox(height:5),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:isSelected || isToday
                            ? Colors.white
                            : Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              ),
          ),

    Expanded(
      child: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {

          if (box.isEmpty) {
            return const Center(child: Text("belum ada tugas"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index) as Map;

              return Dismissible(
                key: Key(index.toString()),
                onDismissed: (_) {
                  box.deleteAt(index);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Checkbox(value: task['done']?? false,
                    onChanged: (value) {
                      box.putAt(index, {
                        "title": task['title'] ?? '',
                        "done": value ?? false,
                      });
                    },
                    ),
                    title: Text(
                      task['title'] ?? '',
                      style: TextStyle(
                        decoration: (task['done'] ?? false)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                );
            }
          );
        },
      ),
    ),
    ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.teal[800],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}