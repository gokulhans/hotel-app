import 'package:educationapp/details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class Tablepage extends StatefulWidget {
  Tablepage({Key? key, required this.title}) : super(key: key);
  final String title;
  // Create a reference to the cities collection

  @override
  State<Tablepage> createState() => _TablepageState();
}

class _TablepageState extends State<Tablepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db
            .collection('orders')
            .where("table", isEqualTo: widget.title)
            .snapshots(),
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
                            title: Text(documentSnapshot['name']),
                            onTap: () => {
                              // add product id into orderid
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Details(
                              //       id: documentSnapshot.id,
                              //       title: documentSnapshot['name'],
                              //     ),
                              //   ),
                              // )
                            },
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                icon:
                                    const Icon(Icons.delete_rounded, size: 18),
                                label: const Text("Order Ready"),
                                onPressed: () {},
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.edit, size: 16),
                                label: const Text("Done"),
                                onPressed: () {
                                  db
                                      .collection('orders')
                                      .doc(documentSnapshot.id)
                                      .delete();
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child:
                                    Text("count " + documentSnapshot['count']),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child:
                                    Text("table " + documentSnapshot['table']),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
