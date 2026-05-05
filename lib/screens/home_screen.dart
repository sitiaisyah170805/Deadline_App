import 'package:deadlineapp/screens/task_category_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.teal[900],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80),
                    )
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.timer, color: Colors.white, size: 50),
                      SizedBox(height: 8),
                      Text(
                        "Deadlin App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "kelola waktumu dengan baik, sks dosen tak suka",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: 20,
                  right: 20,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Text(
                            "Halo",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("siap dengan perubahan hidupmu"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "pilih sesuai keinginanmu",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  //menu grid
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: _menuBox(context, "Homework",
                          Icons.book,
                          Colors.blue[100]!,
                          ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(child: _menuBox(context, "Activity",
                          Icons.event,
                          Colors.orange[100]!,
                          ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(child: _menuBox(context, "Habit",
                          Icons.check_circle,
                          Colors.green[100]!,
                          ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(child: _menuBox(context, "Goal",
                          Icons.track_changes,
                          Colors.purple[100]!,
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              ),
          ],
        ),
        ),
      ),
      );
  }




  //menu box
  // Widget _menuBox(String title, IconData icon, Color color){
  //   return Container(
  //     height: 140,
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(17),
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(icon, size: 30, color: Colors.black54),
  //         const SizedBox(height: 8),
  //         Text(
  //           title,
  //           style: const TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //       ],
  //     ),
  //   );
  // }

Widget _menuBox(
  BuildContext content,
  String title,
  IconData icon,
  Color color,
) {
  return InkWell(
    borderRadius: BorderRadius.circular(17),
    onTap:  () {
      Navigator.push(
      content,
      MaterialPageRoute(
      builder: (context) => TaskCategoryScreen(title: title),
      ),
      );
    },
    child: Container(
      height: 140,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black54),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
}