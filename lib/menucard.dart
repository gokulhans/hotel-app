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
            body: ListTile(
          title: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete_rounded, size: 18),
                          label: const Text("Delete"),
                          onPressed: () {
                            // Perform some action
                            db.collection('products').doc().delete();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
            // TabBarView
            // affold
            ), // DefaultTabController
      ), // DefaultTabController
    ); // MaterialApp
  }
}
