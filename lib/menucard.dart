import 'package:flutter/material.dart';
//Menucard(count: documentSnapshot['count'], des: documentSnapshot['des'], table: documentSnapshot['table'], name: documentSnapshot['name'], image: documentSnapshot['image'])
class Menucard extends StatefulWidget {
  const Menucard(
      {Key? key,
      required this.count,
      required this.des,
      required this.table,
      required this.name,
      required this.image})
      : super(key: key);

  final String count;
  final String des;
  final String table;
  final String name;
  final String image;

  @override
  State<Menucard> createState() => _MenucardState();
}

class _MenucardState extends State<Menucard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               ListTile(
                // leading: Icon(Icons.arrow_drop_down_circle),
                title: Center(
                  child: Text(
                    widget.count,
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
                padding:  EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  decoration:  BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.image
                  ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.des,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.delete_rounded, size: 18),
                      label: const Text("Delete"),
                      onPressed: () {},
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text("Edit"),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
