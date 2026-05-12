import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {

  late final Box settingsBox;

  final TextEditingController nameController =TextEditingController();

  bool isDarkMode = false;
  bool isNotificationOn = true;

  @override
  void initState() {
    super.initState();
    settingsBox = Hive.box('settingsBox');

    nameController.text = 
    settingsBox.get('username', defaultValue: '');

    isDarkMode =
    settingsBox.get('darkMode', defaultValue: false);

    isNotificationOn =
    settingsBox.get('darkMode', defaultValue: true);
  }
  //save name
  void saveName() {

    settingsBox.put(
      'username',
      nameController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Name saved successfully"),
      ),
    );

    setState(() {});
  }

  // 🗑 DELETE ALL DATA
  Future<void> deleteAllData() async {

    await Hive.box('homeworkBox').clear();
    await Hive.box('activityBox').clear();
    await Hive.box('habitBox').clear();
    await Hive.box('goalBox').clear();

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("All task data deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
    Theme.of(context)
        .scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("Settings & Info"),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // 🟢 HEADER
            Text(
              "App Control",

              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Customize your experience.",

              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 25),

            // 📦 MAIN CARD
            Container(

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),

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

                  // 👤 NAME
                  Text(
                    "Your Name",

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: nameController,

                    decoration: InputDecoration(
                      hintText: "Your Name",

                      filled: true,
                      fillColor: Colors.grey[200],

                      prefixIcon: const Icon(
                        Icons.person,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(

                      onPressed: saveName,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[800],
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      child: const Text(
                        "Save Name",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Your name will appear on the home screen.",

                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Divider(),

                  // 🌙 DARK MODE
                  ListTile(

                    contentPadding: EdgeInsets.zero,

                    leading: const Icon(
                      Icons.dark_mode,
                      color: Colors.deepPurple,
                    ),

                    title: const Text(
                      "App Theme",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    subtitle: const Text(
                      "Dark / Light Mode",
                    ),

                    trailing: Switch(

                      value: isDarkMode,

                      activeColor: Colors.teal,

                      onChanged: (value) {

                        setState(() {
                          isDarkMode = value;
                        });

                        settingsBox.put(
                          'darkMode',
                          value,
                        );
                      },
                    ),
                  ),

                  const Divider(),

                  // 🔔 NOTIFICATION
                  ListTile(

                    contentPadding: EdgeInsets.zero,

                    leading: const Icon(
                      Icons.notifications,
                      color: Colors.orange,
                    ),

                    title: const Text(
                      "Notifications",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    subtitle: const Text(
                      "Enable reminders",
                    ),

                    trailing: Switch(

                      value: isNotificationOn,

                      activeColor: Colors.teal,

                      onChanged: (value) {

                        setState(() {
                          isNotificationOn = value;
                        });

                        settingsBox.put(
                          'notification',
                          value,
                        );
                      },
                    ),
                  ),

                  const Divider(),

                  // 🗑 DELETE DATA
                  ListTile(

                    contentPadding: EdgeInsets.zero,

                    leading: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),

                    title: const Text(
                      "Hapus Data Lokal",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),

                    subtitle: const Text(
                      "Delete all local task data.",
                    ),

                    onTap: () {

                      showDialog(

                        context: context,

                        builder: (context) {

                          return AlertDialog(

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),

                            title: const Row(
                              children: [

                                Icon(
                                  Icons.warning_rounded,
                                  color: Colors.red,
                                  size: 30,
                                ),

                                SizedBox(width: 10),

                                Text("Hapus Data"),
                              ],
                            ),

                            content: const Text(
                              "Apakah kamu yakin ingin menghapus semua data task?"
                            ),

                            actions: [

                              TextButton(

                                onPressed: () {
                                  Navigator.pop(context);
                                },

                                child: const Text(
                                  "Batal",

                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                              ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                ),

                                onPressed: () async {

                                  Navigator.pop(context);

                                  await deleteAllData();
                                },

                                child: const Text(
                                  "Hapus",

                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  const Divider(),

                  // 🔒 PRIVACY
                  ListTile(

                    contentPadding: EdgeInsets.zero,

                    leading: const Icon(
                      Icons.lock,
                      color: Colors.teal,
                    ),

                    title: const Text(
                      "Kebijakan Privasi",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    trailing: Text(
                      "Text View",

                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  const Divider(),

                  // 📱 VERSION
                  ListTile(

                    contentPadding: EdgeInsets.zero,

                    leading: const Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),

                    title: const Text(
                      "Versi Aplikasi",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    trailing: const Text(
                      "V.1.0.0",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}