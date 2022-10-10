import 'package:educationapp/details.dart';
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  heroTag: "btn1",
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
              ),
              FloatingActionButton(
                backgroundColor: Colors.red,
                heroTag: "btn2", //unique id for floatadction btn
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
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('ADMIN PANEL'),
          centerTitle: true,
        ),
        body: StreamBuilder(
            // Reading Items form our Database Using the StreamBuilder widget
            stream: db.collection('products').orderBy("name").snapshots(),
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
                        ListTile(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(
                                  id: documentSnapshot.id,
                                  title: documentSnapshot['name'],
                                ),
                              ),
                            )
                          },
                          title: Text(documentSnapshot['name']),
                          // title:Text(documentSnapshot['table']) ,
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ButtonBar(
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
                                    icon: const Icon(Icons.edit, size: 16),
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
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }));
  }
}

addCategory(
    BuildContext context, bool isUpdate, DocumentSnapshot? documentSnapshot) {
  // Added the isUpdate argument to check if our item has been updated
  return SafeArea(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: ListView(
          children: [
            ListTile(
              // width: MediaQuery.of(context).size.width * 0.9,
              title: Column(
                children: [
                  // TextField(
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
      ),
    ),
  );
}


showBottomSheet(
    BuildContext context, bool isUpdate, DocumentSnapshot? documentSnapshot) {
  // Added the isUpdate argument to check if our item has been updated
  return SafeArea(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(45),
        child: ListView(
          children: [
            ListTile(
              // width: MediaQuery.of(context).size.width * 0.9,
              title: Column(
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
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
      ),
    ),
  );
}

editPage(BuildContext context, DocumentSnapshot? documentSnapshot) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.all(5),
      child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: ListView(children: [
            ListTile(
                // width: MediaQuery.of(context).size.width * 0.9,
                title: Column(children: [
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
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
                ])),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  // Check to see if isUpdate is true then update the value else add the value
                  // print({value,image,des,type,category,price,available});
                  value ??= documentSnapshot?['name'];
                  image ??= documentSnapshot?['image'];
                  des ??= documentSnapshot?['des'];
                  type ??= documentSnapshot?['type'];
                  category ??= documentSnapshot?['category'];
                  price ??= documentSnapshot?['price'];
                  available ??= documentSnapshot?['available'];
                  // ignore: avoid_print
  
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
          ])),
    ),
  );
}


/*
 



*/