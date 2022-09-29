import 'package:educationapp/allcats.dart';
import 'package:flutter/material.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key? key}) : super(key: key);

// build the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
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
    ); // MaterialApp
  }
}
