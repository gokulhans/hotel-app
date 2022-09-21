import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
String? value;
String? image;
String? des;
String? count;

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db.collection('eduapp').snapshots(),
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
                            // leading: const Icon(Icons.arrow_drop_down_circle),
                            title: Text(documentSnapshot['name']),
                            // subtitle: Text(
                            //   'Secondary Text',
                            //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            // ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              documentSnapshot['des'],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                // style: TextButton.styleFrom(for),
                                onPressed: () {
                                  // Perform some action
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return addOrder(
                                          context, documentSnapshot);
                                    },
                                  );
                                },
                                child: const Text('Order'),
                              ),
                            ],
                          ),
                          Image.network(documentSnapshot['image']),
                          // https://picsum.photos/250?image=9
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
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
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
                'id': documentSnapshot?.id,
                'image': documentSnapshot?['image'],
                'des': documentSnapshot?['des'],
                'name': documentSnapshot?['name'],
                'count': count
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
