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
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('All Orders'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db.collection('orders').snapshots(),
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
                            // onTap: () => {
                            //                 Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Tablepage(title: 'f',),
                            //     ),
                            //   )
                            // },
                            title: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                   ListTile(
                                    // leading: Icon(Icons.arrow_drop_down_circle),
                                    title: Center(
                                      child: Text(
                                        documentSnapshot['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    // subtitle: Text(
                                    //   'Secondary Text',
                                    //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    // ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(documentSnapshot['image']),
                                      )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      documentSnapshot['des'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.delete_rounded,
                                              size: 18),
                                          label: const Text("Order Ready"),
                                          onPressed: () {},
                                        ),
                                        ElevatedButton.icon(
                                          icon:
                                              const Icon(Icons.edit, size: 16),
                                          label: const Text("Done"),
                                          onPressed: () {
                                            db
                                                .collection('orders')
                                                .doc(documentSnapshot.id)
                                                .delete();
                                          },
                                        ),
                                         ElevatedButton(
                                         
                                          onPressed: () {
                                            
                                          },
                                          child: Text("count " + documentSnapshot['count']),
                                        ),
                                         ElevatedButton(
                                         
                                          onPressed: () {
                                            
                                          },
                                          child: Text("table "+ documentSnapshot['table']),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
