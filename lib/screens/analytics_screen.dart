import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _analyticsScreenState();
}

class _analyticsScreenState extends State<AnalyticsScreen> {
  late final Box homeworkBox;
  late final Box activityBox;
  late final Box habitBox;
  late final Box goalBox;

  @override
  void initState() {
    super.initState();

    homeworkBox = Hive.box('homeworkBox');
    activityBox = Hive.box('activityBox');
    habitBox = Hive.box('habitBox');
    goalBox = Hive.box('goalBox');
  }

  int get totalTasks {
    return homeworkBox.length +
    activityBox.length +
    habitBox.length +
    goalBox.length;
  }

  int get completedTasks {
    int totalCompleted = 0;

    List<Box> allBoxes = [
      homeworkBox,
      activityBox,
      habitBox,
      goalBox,
    ];
    for (var box in allBoxes) {
      for (var task in box.values) {
        if (task['done'] == true) {
          totalCompleted++;
        }
      }
    }
    return totalCompleted;
  }

double get progress {
  if (totalTasks == 0) return 0;

  return completedTasks / totalTasks;
}

int get pendingTasks {
  return totalTasks - completedTasks;
}
//colorbox
Color getCategoryColor(String category) {

  switch (category) {

    case 'Homework' :
    return Colors.pink.shade200;

    case 'Activity' :
    return Colors.orange.shade200;

    case 'Habit' :
    return Colors.green.shade200;

    case 'Goal' :
    return Colors.purple.shade200;

    default:
    return Colors.grey.shade300;
  }
}
@override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Task Analytics"),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // 📊 HEADER
            Text(
              "Overview",

              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 20),

            
            _buildMainCard(
              title: "Total Tasks",
              value: totalTasks.toString(),
              icon: Icons.assignment,
            ),

            const SizedBox(height: 16),

          
            Row(
              children: [

                Expanded(
                  child: _buildSmallCard(
                    title: "Completed",
                    value: completedTasks.toString(),
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildSmallCard(
                    title: "Pending",
                    value: pendingTasks.toString(),
                    icon: Icons.access_time,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // 📈 PROGRESS TITLE
            Text(
              "Progress",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 15),

            // progress card
            Container(
              padding: const EdgeInsets.all(20),

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

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "${(progress * 100).toInt()}% Completed",

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 14,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(
                        Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🏷 CATEGORY TITLE
            Text(
              "Category Breakdown",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 15),

            // 🏷 CATEGORY CARDS
            _buildCategoryCard(
              "Homework",
              homeworkBox.length,
              getCategoryColor("Homework"),
            ),

            const SizedBox(height: 12),

            _buildCategoryCard(
              "Activity",
              activityBox.length,
              getCategoryColor("Activity"),
            ),

            const SizedBox(height: 12),

            _buildCategoryCard(
              "Habit",
              habitBox.length,
              getCategoryColor("Habit"),
            ),

            const SizedBox(height: 12),

            _buildCategoryCard(
              "Goal",
              goalBox.length,
              getCategoryColor("Goal"),
            ),
          ],
        ),
      ),
    );
  }

  //main card
  Widget _buildMainCard({
    required String title,
    required String value,
    required IconData icon,
  }) {

    return Container(
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,

                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 8),

              Text(
                value,

                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Icon(
            icon,
            size: 45,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }

  //card
  Widget _buildSmallCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {

    return Container(
      padding: const EdgeInsets.all(20),

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

      child: Column(
        children: [

          Icon(
            icon,
            size: 35,
            color: color,
          ),

          const SizedBox(height: 10),

          Text(
            value,

            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,

            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // 🏷 CATEGORY CARD
  Widget _buildCategoryCard(
    String title,
    int total,
    Color color,
  ) {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            "$total Tasks",

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
