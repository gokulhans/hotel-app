import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final db = FirebaseFirestore.instance;
String? value;
String? image;
String? des;


class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          // When the User clicks on the button, display a BottomSheet
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return showBottomSheet(context, false, null);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('name App'),
        centerTitle: true,
      ),
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
            title:  Text(documentSnapshot['name']),
            // subtitle: Text(
            //   'Secondary Text',
            //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              // IconButton(
              //     icon: const Icon(
              //       Icons.delete_outline,
              //     ),
              //     onPressed: () {
              //       // Here We Will Add The Delete Feature
              //       db.collection('eduapp').doc(documentSnapshot.id).delete();
              //     },
              //   ),
              TextButton(
                // textColor: const Color(0xFF6200EE),
                onPressed: () {
                  // Perform some action
                    db.collection('eduapp').doc(documentSnapshot.id).delete();

                },
                child: const Text('Delete'),
              ),
              TextButton(
                // style: TextButton.styleFrom(for),
                onPressed: () {
                  // Perform some action
                   showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return showBottomSheet(context, true, documentSnapshot);
                    },
                  );
                },
                child: const Text('Edit'),
              ),
            ],
          ),
          // Image.network('https://picsum.photos/250?image=9'),
          
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
                  labelText: isUpdate ? 'Update name' : 'Add name',
                  hintText: 'Enter An Item',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  value = _val;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: isUpdate ? 'Update image' : 'Add image',
                  hintText: 'Enter An image link',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  image = _val;
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
                db.collection('eduapp').doc(documentSnapshot?.id).update({
                  'name': value,
                });
              } else {
                db.collection('eduapp').add({'name': value});
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
