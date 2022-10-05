import 'package:educationapp/admin.dart';
import 'package:educationapp/allcats.dart';
import 'package:educationapp/alltables.dart';
import 'package:educationapp/cat.dart';
import 'package:educationapp/menu.dart';
import 'package:educationapp/menucard.dart';
import 'package:educationapp/orders.dart';
import 'package:educationapp/search.dart';
import 'package:educationapp/sidebar.dart';
import 'package:educationapp/table.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

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
          primarySwatch: Colors.green,
        ),
        routes: {
          'admin': (ctx) {
            return const AdminPage();
          },
          'orders': (ctx) {
            return const Orders();
          },
          'menu': (ctx) {
            return const Menu(title: 'OUT');
          },
          'test': (ctx) {
            return const TabBarDemo();
          },
          'alltables': (ctx) {
            return const AllTables();
          },
          'table': (ctx) {
            return Tablepage(
              title: 'df',
            );
          },
          'allcats': (ctx) {
            return const AllCats(
              title: 'IN',
            );
          },
          'cat': (ctx) {
            return const Catpage(
              table: 'snacks',
              title: 'snacks',
              type: 'IN',
            );
          },
          'search': (ctx) {
            return const Searchbar();
          },
        },
        home: const SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromARGB(255, 43, 42, 40),body: Center(child: Image.asset('logo.jpg')));
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: const NavDrawer(),
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.food_bank),
                  text: 'IN',
                ),
                Tab(
                  icon: Icon(Icons.food_bank),
                  text: 'OUT',
                ),
              ],
            ), // TabBar
            title: const Text('NatuRoots'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ), // AppBar
          body: const TabBarView(
            children: [
              AllCats(title: 'IN'),
              AllCats(title: 'OUT'),
            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController,
    );
  }
}
