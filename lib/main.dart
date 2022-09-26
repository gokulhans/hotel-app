import 'package:educationapp/admin.dart';
import 'package:educationapp/allcats.dart';
import 'package:educationapp/alltables.dart';
import 'package:educationapp/cat.dart';
import 'package:educationapp/menu.dart';
import 'package:educationapp/orders.dart';
import 'package:educationapp/searchbar.dart';
import 'package:educationapp/sidebar.dart';
import 'package:educationapp/table.dart';
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
          return const AdminPage();
        },
        'orders': (ctx) {
          return const Orders();
        },
        'menu': (ctx) {
          return const Menu(title:'OUT');
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
          return const AllCats(title: 'IN',);
        },
        'cat': (ctx) {
          return Catpage(
            title: 'snacks',
            type: 'IN',
          );
        },
        'search': (ctx) {
          return const Search();
        },
      },
      home: const DefaultTabController(
        length: 2,
        child: Scaffold(body: MainPage()),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        bottom:  const TabBar(
          isScrollable: true,
          tabs: [
            Tab(text: 'OUT',),
            Tab(text: 'IN'),
          ],
        ),
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
        actions: [],
        iconTheme: const IconThemeData(color: Colors.green),
      ),
      // body: const SingleChildScrollView(child: Menu()),
      body: const TabBarView(
        children: [
          AllCats(title: 'IN'),
          AllCats(title:'OUT'),
        ],
      ),
    );
  }

  // Future<void> saveNote() async {
  //   final test = NoteDB().test();
  //   print(test);
  //   return test;
  // }
}

 // IconButton(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   icon: const Icon(
          //     Icons.admin_panel_settings,
          //     color: Colors.teal,
          //   ),
          //   onPressed: () {
          //     // AdmobHelper.createInterad();
          //     // AdmobHelper.showInterad();
          //     Navigator.of(context).pushNamed('admin');
          //   },
          // ),
          // IconButton(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   icon: const Icon(
          //     Icons.food_bank,
          //     color: Colors.teal,
          //   ),
          //   onPressed: () {
          //     // AdmobHelper.createInterad();
          //     // AdmobHelper.showInterad();
          //     Navigator.of(context).pushNamed('orders');
          //   },
          // ),
          // IconButton(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   icon: const Icon(
          //     Icons.menu_book,
          //     color: Colors.teal,
          //   ),
          //   onPressed: () {
          //     // AdmobHelper.createInterad();
          //     // AdmobHelper.showInterad();
          //     Navigator.of(context).pushNamed('menu');
          //   },
          // ),
          // IconButton(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   icon: const Icon(
          //     Icons.table_bar,
          //     color: Colors.teal,
          //   ),
          //   onPressed: () {
          //     // AdmobHelper.createInterad();
          //     // AdmobHelper.showInterad();
          //     Navigator.of(context).pushNamed('alltables');
          //   },
          // ),