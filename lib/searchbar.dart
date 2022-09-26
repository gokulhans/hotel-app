import 'package:educationapp/singlemenu.dart';
import 'package:flutter/material.dart';

String search = 'Guys';

class Search extends StatelessWidget {
  const Search({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           children: [
             TextFormField(
                   decoration: const InputDecoration(
                     border: OutlineInputBorder(),
                     // Used a ternary operator to check if isUpdate is true then display
                     // Update name.
                     labelText: 'TYPE TO SEARCH',
                     hintText: 'SEARCH',
                   ),
                   onChanged: (String _val) {
                     // Storing the value of the text entered in the variable value.
                     search = _val;
                   },
                 ),
             ElevatedButton.icon(
               icon: const Icon(Icons.search, size: 18),
               label: const Text("Search"),
               onPressed: () {
                 print(search);
                 // Perform some action
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => SingleMenu(title: search),
                   ),
                 );
               },
             ),
           ],
         ),
       ),
    );
  }
}