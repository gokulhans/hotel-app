import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
String? value;
String? image;
String? des;
String? count;

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // When the User clicks on the button, display a BottomSheet
      //     showModalBottomSheet(
      //       context: context,
      //       builder: (context) {
      //         return showBottomSheet(context, false, null);
      //       },
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
      appBar: AppBar(
        title: const Text('Orders'),
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
                            // leading: const Icon(Icons.arrow_drop_down_circle),
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
                                        style: TextStyle(
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
                                    padding: const EdgeInsets.only(left: 2),
                                    child: ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.delete_rounded,
                                              size: 18),
                                          onPressed: () {
                                            // Perform some action
                                            db
                                                .collection('orders')
                                                .doc(documentSnapshot.id)
                                                .delete();
                                          },
                                          label: const Text('Remove'),
                                        ),
                                        ElevatedButton.icon(
                                          icon:
                                              const Icon(Icons.edit, size: 16),
                                          onPressed: () {
                                            // Perform some action
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return showBottomSheet(context,
                                                    true, documentSnapshot);
                                              },
                                            );
                                          },
                                          label: const Text('Edit Count'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child:
                                              Text(documentSnapshot['count']),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(documentSnapshot['spec']),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // subtitle: Text(
                            //   'Secondary Text',
                            //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            // ),
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

showBottomSheet(
    BuildContext context, bool isUpdate, DocumentSnapshot? documentSnapshot) {
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
                  labelText: isUpdate ? 'Update Count' : 'Add Description',
                  hintText: 'Enter count',
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
              // Check to see if isUpdate is true then update the value else add the value
              if (isUpdate) {
                db
                    .collection('orders')
                    .doc(documentSnapshot?.id)
                    .update({'count': count});
              } else {
                db
                    .collection('products')
                    .add({'name': value, 'image': image, 'des': des});
              }
              Navigator.pop(context);
            },
            child: isUpdate
                ? const Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.white),
                  )
                : const Text('ADD', style: TextStyle(color: Colors.white))),
      ],
    ),
  );
}
