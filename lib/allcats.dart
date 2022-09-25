import 'package:educationapp/cat.dart';
import 'package:educationapp/menucard.dart';
import 'package:educationapp/table.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
String search = '';

class AllCats extends StatefulWidget {
  const AllCats({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<AllCats> createState() => _AllCatsState();
}

class _AllCatsState extends State<AllCats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // Used a ternary operator to check if isUpdate is true then display
                // Update name.
                labelText: 'TYPE TO SEARCH',
                hintText: 'SEARCH',
              ),
              onChanged: (String _val) {
                // Storing the value of the text entered in the variable value.
                search = _val;
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.search, size: 18),
              label: const Text("Search"),
              onPressed: () {
                // Perform some action
                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Menucard(
                                      title: search),
                                ),
                              )
              },
            ),
          ],
        ),
        title: const Text('All Categories'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db.collection('category').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, int index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              return ListTile(
                title: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Catpage(
                                      title: documentSnapshot['cat'],
                                      type: widget.title),
                                ),
                              )
                            },
                            title: Text(documentSnapshot['cat']),
                            // title:Text(documentSnapshot['table']) ,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
