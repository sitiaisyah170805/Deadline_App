
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'navigation_menu.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // 📦 OPEN BOXES
  await Hive.openBox('homeworkBox');
  await Hive.openBox('activityBox');
  await Hive.openBox('habitBox');
  await Hive.openBox('goalBox');
  await Hive.openBox('settingsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(

      valueListenable:
          Hive.box('settingsBox').listenable(),

      builder: (context, box, _) {

        bool isDarkMode =
            box.get(
              'darkMode',
              defaultValue: false,
            );

        return MaterialApp(

          debugShowCheckedModeBanner: false,

          title: 'Deadline',

          // 🌙 THEME MODE
          themeMode:
              isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,

          // ☀ LIGHT THEME
          theme: ThemeData(

            brightness: Brightness.light,

            primarySwatch: Colors.teal,

            scaffoldBackgroundColor:
                const Color(0xFFF5F7F8),

            appBarTheme: AppBarTheme(
              backgroundColor: Colors.teal[800],
              foregroundColor: Colors.white,
              elevation: 0,
            ),

            navigationBarTheme:
                NavigationBarThemeData(

              backgroundColor: Colors.white,

              indicatorColor:
                  Colors.teal.shade100,

              labelTextStyle:
                  WidgetStateProperty.all(

                const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            useMaterial3: true,
          ),
          
          darkTheme: ThemeData(

            brightness: Brightness.dark,

          scaffoldBackgroundColor:
              const Color(0xFF121212),
              

            textTheme: const TextTheme(

            bodyLarge: TextStyle(
              color: Colors.black,
            ),

            bodyMedium: TextStyle(
              color: Colors.black,
            ),
          ),

          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
          ),

          navigationBarTheme:
              NavigationBarThemeData(

            backgroundColor:
                const Color(0xFF1E1E1E),

            indicatorColor: Colors.teal,

            iconTheme:
            WidgetStateProperty.all(

              const IconThemeData(
                color: Colors.white,
              ),
            ),


            labelTextStyle:
                WidgetStateProperty.all(

              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          useMaterial3: true,
        ),

                  home: const NavigationMenu(),
                );
              },
            );
          }
        }


