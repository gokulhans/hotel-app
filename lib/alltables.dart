import 'package:educationapp/menucard.dart';
import 'package:educationapp/table.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class AllTables extends StatelessWidget {
  const AllTables({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('All Orders'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db.collection('tables').orderBy("table").snapshots(),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         
                          Flexible(
                            child: ListTile(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Tablepage(
                                      title: documentSnapshot['table'],
                                    ),
                                  ),
                                )
                              },
                              title: Text(documentSnapshot['table']),
                              // title:Text(documentSnapshot['table']) ,
                              
                            ),
                          ),
                             ButtonBar(
                                      alignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.delete_rounded,
                                              size: 18),
                                          label: const Text("Delete"),
                                          onPressed: () {
                                            // Perform some action
                                            db
                                                .collection('tables')
                                                .doc(documentSnapshot.id)
                                                .delete();
                                          },
                                        ),
                                       
                                      ],
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
