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
          return Catpage(
            title: 'snacks',
            type: 'IN',
          );
        },
        'search': (ctx) {
          return const Searchbar();
        },
      },
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
      drawer: const NavDrawer(),
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.food_bank ), text: 'IN',),
                Tab(icon: Icon(Icons.food_bank), text: 'OUT',),
              ],
            ), // TabBar
            title: const Center(child: Text('NatuRoots')),
            backgroundColor: Colors.green,
          ), // AppBar
          body: const TabBarView(
            children: [
              AllCats(title: 'IN'),
              AllCats(title: 'OUT'),
            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController
    );
  }
}
