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

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // When the User clicks on the button, display a BottomSheet
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return showBottomSheet(context, false, null);
            },
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('ADMIN PANEL'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        // Reading Items form our Database Using the StreamBuilder widget
        stream: db.collection('products').snapshots(),
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
                                    padding: const EdgeInsets.only(left: 2),
                                    child: ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.delete_rounded,
                                              size: 18),
                                          label: const Text("Delete"),
                                          onPressed: () {
                                            // Perform some action
                                            db
                                                .collection('products')
                                                .doc(documentSnapshot.id)
                                                .delete();
                                          },
                                        ),
                                        ElevatedButton.icon(
                                          icon:
                                              const Icon(Icons.edit, size: 16),
                                          label: const Text("Edit"),
                                          onPressed: () {
                                            // Perform some action
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return editPage(
                                                    context, documentSnapshot);
                                              },
                                              isScrollControlled: true,
                                            );
                                          },
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
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText:
                      isUpdate ? 'Update Description' : 'Add Description',
                  hintText: 'Enter Description',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  des = _val;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: isUpdate ? 'Update Type' : 'Add Type IN or OUT',
                  hintText: 'Enter Type',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  type = _val;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: isUpdate ? 'Update Price' : 'Add Price',
                  hintText: 'Enter Price',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  price = _val;
                },
              ),
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
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: isUpdate
                      ? 'Update available'
                      : 'Add available, yes or no',
                  hintText: 'Enter available',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  available = _val;
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
                db.collection('products').doc(documentSnapshot?.id).update({
                  'name': value,
                  'image': image,
                  'des': des,
                  'category': category,
                  'type': type,
                  'price': price,
                  'available': available
                });
              } else {
                db.collection('products').add({
                  'name': value,
                  'image': image,
                  'des': des,
                  'category': category,
                  'type': type,
                  'price': price,
                  'available': available
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
        TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.lightBlueAccent),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('back', style: TextStyle(color: Colors.white)))
      ],
    ),
  );
}

editPage(BuildContext context, DocumentSnapshot? documentSnapshot) {
  value = documentSnapshot?['name'];
  image = documentSnapshot?['image'];
  des = documentSnapshot?['des'];
  type = documentSnapshot?['type'];
  category = documentSnapshot?['category'];
  price = documentSnapshot?['price']; // use num data type
  available = documentSnapshot?['available'];
  // ignore: avoid_print

  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              TextFormField(
                initialValue: documentSnapshot?['name'],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'Update name',
                  hintText: 'Enter An Item',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  value = _val;
                },
              ),
              TextFormField(
                initialValue: documentSnapshot?['image'],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'Update image',
                  hintText: 'Enter An image link',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  image = _val;
                },
              ),
              TextFormField(
                initialValue: documentSnapshot?['des'],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'Update Description',
                  hintText: 'Enter Description',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  des = _val;
                },
              ),
              TextFormField(
                initialValue: documentSnapshot?['type'],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'Update Type',
                  hintText: 'Enter Type',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  type = _val;
                },
              ),
              TextFormField(
                initialValue: documentSnapshot?['price'],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'Update Price',
                  hintText: 'Enter Price',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  price = _val;
                },
              ),
              TextFormField(
                initialValue: documentSnapshot?['category'],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'Update category',
                  hintText: 'Enter category',
                ),
              ),
              TextFormField(
                readOnly: true,
                initialValue: documentSnapshot?['available'],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // Used a ternary operator to check if isUpdate is true then display
                  // Update name.
                  labelText: 'Update available',
                  hintText: 'Enter available',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  available = _val;
                },
              ),
              DropdownButton<String>(
                value: documentSnapshot?['available'],
                items: <String>['yes', 'no'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  available = value;
                },
              )
            ],
          ),
        ),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () {
              // Check to see if isUpdate is true then update the value else add the value
              // print({value,image,des,type,category,price,available});

              db.collection('products').doc(documentSnapshot?.id).update({
                'name': value,
                'image': image,
                'des': des,
                'category': category,
                'type': type,
                'price': price,
                'available': available
              });

              Navigator.pop(context);
            },
            child: const Text(
              'UPDATE',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('back', style: TextStyle(color: Colors.white)))
      ],
    ),
  );
}
