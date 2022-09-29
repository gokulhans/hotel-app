import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;


String? value;
String? image;
String? des;
String? count;
bool? order = false;
String? table = 'undefined';
String? spec = 'no specification';




class Catpage extends StatefulWidget {
  Catpage({Key? key, required this.title,required this.type}) : super(key: key);
  final String title;
  final String type;
  // Create a reference to the cities collection
        
    
  @override
  State<Catpage> createState() => _CatpageState();
}

class _CatpageState extends State<Catpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db.collection('eduapp').where("category",isEqualTo: widget.title ).where("type",isEqualTo: widget.type ).snapshots(),
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
                                            icon: const Icon(
                                                Icons.food_bank,
                                                size: 18),
                                            label: const Text("Order"),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return addOrder(context,
                                                        documentSnapshot);
                                                  });
                                            }),
                                        ElevatedButton.icon(
                                            icon:  Icon(
                                                Icons.price_change,
                                                size: 18),
                                            label:  Text(documentSnapshot['price']),
                                            onPressed: (){},
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

addOrder(BuildContext context, DocumentSnapshot? documentSnapshot) {
  // Added the isUpdate argument to check if our item has been updated
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'No. of items',
                  hintText: 'Enter A number',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  count = _val;
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'Any Specification',
                  hintText: 'Enter specification',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  spec = _val;
                },
              ),
            ],
          ),
        ),
        TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.lightBlueAccent),
            ),
            onPressed: () {
              db.collection('orders').add({
                'image': documentSnapshot?['image'],
                'des': documentSnapshot?['des'],
                'name': documentSnapshot?['name'],
                'count': count,
                'table': table,
                'spec': spec,
              });

              Navigator.pop(context);
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            )),
      ],
    ),
  );
}
