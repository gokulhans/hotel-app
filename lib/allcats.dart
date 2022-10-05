import 'package:educationapp/cat.dart';
import 'package:educationapp/menucard.dart';
import 'package:educationapp/singlemenu.dart';
import 'package:educationapp/table.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
String table = 'undefined';

class AllCats extends StatefulWidget {
  const AllCats({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<AllCats> createState() => _AllCatsState();
}

class _AllCatsState extends State<AllCats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // When the User clicks on the button, display a BottomSheet
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return addNewOrder(context);
            },
          );
        },
        child: const Icon(Icons.add),
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
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Catpage(
                                      title: documentSnapshot['cat'],
                                      table: table,
                                      type: widget.title),
                                ),
                              )
                            },
                            title: Text(documentSnapshot['cat']),
                            // title:Text(documentSnapshot['table']) ,
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

addNewOrder(BuildContext context) {
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
                  labelText: 'User table',
                  hintText: 'Enter table',
                ),
                onChanged: (String _val) {
                  // Storing the value of the text entered in the variable value.
                  table = _val;
                },
              ),
            ],
          ),
        ),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () {
              db.collection('tables').add({'table': table});
              Navigator.pop(context);
            },
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            )),
      ],
    ),
  );
}
