import 'package:educationapp/menucard.dart';
import 'package:educationapp/table.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
String? value;
String? image;
String? des;
String? type;
String? category;
String? price; // use num data type
String? available;

class AllCategories extends StatelessWidget {

  

  const AllCategories({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          // When the User clicks on the button, display a BottomSheet
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return addCategory(context, false, null);
            },
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.category),
      ),
      appBar: AppBar(
        title: const Text('All Categories'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db.collection('category').orderBy("cat").snapshots(),
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
                              title: Text(documentSnapshot['cat']),
                              // subtitle: Text(documentSnapshot['type']),
                              // title:Text(documentSnapshot['table']) ,
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                icon:
                                    const Icon(Icons.delete_rounded, size: 18),
                                label: const Text("Delete"),
                                onPressed: () {
                                  // Perform some action
                                  db
                                      .collection('category')
                                      .doc(documentSnapshot.id)
                                      .delete();
                                },
                              ),
                              // ElevatedButton.icon(
                              //   icon:
                              //       const Icon(Icons.edit, size: 18),
                              //   label: const Text("Edit"),
                              //   onPressed: () {
                              //     // When the User clicks on the button, display a BottomSheet
                              //     showModalBottomSheet(
                              //       context: context,
                              //       builder: (context) {
                              //         return addCategory(context, true, null);
                              //       },
                              //       isScrollControlled: true,
                              //     );
                              //   },
                              // ),
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


addCategory(
    BuildContext context, bool isUpdate, DocumentSnapshot? documentSnapshot) {
  // Added the isUpdate argument to check if our item has been updated
  return Padding(
    padding: const EdgeInsets.only(top: 100),
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
                  labelText: isUpdate ? 'Update category' : 'Add category',
                  hintText: 'Enter category',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  category = _val;
                },
              ),
              //  TextField(
              //   decoration: InputDecoration(
              //     border: const OutlineInputBorder(),
              //     // Used a ternary operator to check if isUpdate is true then display
              //     // Update name.
              //     labelText: isUpdate ? 'Update type' : 'Add type',
              //     hintText: 'Enter An Item',
              //   ),
              //   onChanged: (String _val) {
              //     // Storing the value of the text entered in the variable value.
              //     type = _val;
              //   },
              // ),
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
                db.collection('category').doc(documentSnapshot?.id).update({
                  'cat': category,
                  // 'type': type,
                });
              } else {
                db.collection('category').add({
                  'cat': category,
                  // 'type': type,
                });
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
