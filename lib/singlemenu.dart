import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class SingleMenu extends StatefulWidget {
  const SingleMenu({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SingleMenuState createState() => _SingleMenuState();
}

class _SingleMenuState extends State<SingleMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db
            .collection('products')
            .where("name", isEqualTo: widget.title)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data?.docs.length == 0) {
            return const Center(
              child: Text('item not found, Tip:  search exact word'),
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
                                        image: NetworkImage(
                                            documentSnapshot['image']),
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
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      documentSnapshot['price'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      documentSnapshot['available'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      documentSnapshot['category'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      documentSnapshot['type'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
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
