import 'package:educationapp/admin.dart';
import 'package:educationapp/demo.dart';
import 'package:educationapp/menucard.dart';
import 'package:educationapp/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDpUCF3RBAzTiGHThgKUoXtYuu7c6BZC7Q",
      appId: "education-app-829f1",
      messagingSenderId: "286082938001",
      projectId: "education-app-829f1",
    ),
  );
  runApp(
    const MyApp(),
  );
}

final db = FirebaseFirestore.instance;
String? value;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'admin': (ctx) {
          return AdminPage();
        },},
      home: const Scaffold(body: MainPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    const Home(),
    const Courses(),
    const Syllabus(),
    const AdminPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        ),
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Hotel Disoosa",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            icon: const Icon(
              Icons.admin_panel_settings,
              color: Colors.teal,
            ),
            onPressed: () {
              // AdmobHelper.createInterad();
              // AdmobHelper.showInterad();
              Navigator.of(context).pushNamed('admin');
            },
          )
        ],
        iconTheme: const IconThemeData(color: Colors.green),
      ),
      body: const SingleChildScrollView(child: MenuCard()),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          unselectedLabelStyle: const TextStyle(
            color: Colors.grey,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.green,
          ),
          selectedLabelStyle: const TextStyle(
            color: Colors.green,
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
            BottomNavigationBarItem(
                icon: Icon(Icons.graphic_eq_outlined), label: 'Syllabus'),
            BottomNavigationBarItem(

              icon: Icon(
                Icons.notifications,
                // color: Colors.red,
              ),
              
              label: 'Notis',
            ),
          ]),
    );
  }

  // Future<void> saveNote() async {
  //   final test = NoteDB().test();
  //   print(test);
  //   return test;
  // }
}
