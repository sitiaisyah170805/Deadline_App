import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  late final Box homeworkBox;
  late final Box activityBox;
  late final Box habitBox;
  late final Box goalBox;

  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    homeworkBox = Hive.box('homeworkBox');
    activityBox = Hive.box('activityBox');
    habitBox = Hive.box('habitBox');
    goalBox = Hive.box('goalBox');
  }
  List<Map> getTasksForSelectedDate() {
    List<Map> filteredTasks = [];
    List<Box> allBoxes = [
      homeworkBox,
      activityBox,
      habitBox,
      goalBox,
    ];
    for (var box in allBoxes) {
      for (var task in box.values) {
        if (task['date'] == null) continue;

        DateTime taskDate = DateTime.parse(task['date']);

        if (
          taskDate.year == selectedDay.year &&
          taskDate.month == selectedDay.month &&
          taskDate.day == selectedDay.day
        ) {
          filteredTasks.add({
            ...Map<String, dynamic>.from(task),

            "category": box == homeworkBox
            ? "Homework"
            : box == activityBox
            ? "Activity"
            : box == habitBox
            ? "Habit"
            : "Goal",
          });
        }
      }
    }
    return filteredTasks;
  }
  Color getCategoryColor(String category) {

    switch (category) {

      case 'Homework':
        return Colors.pink.shade200;

      case 'Activity':
        return Colors.orange.shade200;

      case 'Habit':
        return Colors.green.shade200;

      case 'Goal':
        return Colors.purple.shade200;

      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {

    final tasks = getTasksForSelectedDate();

    return Scaffold(

      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Deadline Calendar"),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      body: Column(
        children: [

          const SizedBox(height: 10),

          // 📅 CALENDAR
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: TableCalendar(

              focusedDay: today,
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),

              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },

              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDay = selected;
                  today = focused;
                });
              },

              calendarStyle: CalendarStyle(

                todayDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),

                selectedDecoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),

                weekendTextStyle: const TextStyle(
                  color: Colors.red,
                ),

                outsideDaysVisible: false,
              ),

              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // 📝 TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  "Daily Deadlines",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),

                Text(
                  "${tasks.length} Tasks",

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // 📝 TASK LIST
          Expanded(

            child: tasks.isEmpty

                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(
                          Icons.event_note,
                          size: 70,
                          color: Colors.grey[400],
                        ),

                        const SizedBox(height: 15),

                        Text(
                          "No Tasks Yet",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Tasks for this date will appear here",

                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )

                : ListView.builder(

                    padding: const EdgeInsets.symmetric(horizontal: 16),

                    itemCount: tasks.length,

                    itemBuilder: (context, index) {

                      final task = tasks[index];

                      return Padding(

                        padding: const EdgeInsets.only(bottom: 12),

                        child: _buildTaskCard(

                          title: task['title'] ?? '',

                          category: task['category'],

                          color: getCategoryColor(
                            task['category'],
                          ),

                          isDone: task['done'] ?? false,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // 🎴 TASK CARD
  Widget _buildTaskCard({
    required String title,
    required String category,
    required Color color,
    required bool isDone,
  }) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 📝 TITLE
          Text(
            title,

            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,

              decoration: isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),

          const SizedBox(height: 10),

          // 🏷 CATEGORY LABEL
          Container(

            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(

              category,

              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          
          if (isDone) ...[

            const SizedBox(height: 10),

            const Text(
              "Completed",

              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ],
      ),
    );
  }
}