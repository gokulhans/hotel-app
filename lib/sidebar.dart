import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image:NetworkImage("https://cdn.pixabay.com/photo/2010/12/13/10/25/canape-2802_960_720.jpg"),
                )),
              ),
            ),
          ),
       
         
          ListTile(
            leading: const Icon(Icons.copyright_sharp),
            title: const Text('Menu'),
            onTap: () => {Navigator.of(context).pushNamed('menu')},
          ),
          ListTile(
            leading: const Icon(Icons.copyright_sharp),
            title: const Text('Orders'),
            onTap: () => {Navigator.of(context).pushNamed('orders')},
          ),
          // ListTile(
          //   leading: Icon(Icons.favorite,color: Colors.red,),
          //   title: Text('Support Us',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900),),
          //   onTap: () => {Navigator.of(context).pushNamed('support')},
          // ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('All Tables'),
            onTap: () => {Navigator.of(context).pushNamed('alltables')},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('All Categories'),
            onTap: () => {Navigator.of(context).pushNamed('allcats')},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Admin Page'),
            onTap: () => {Navigator.of(context).pushNamed('admin')},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Search Page'),
            onTap: () => {Navigator.of(context).pushNamed('search')},
          ),
         
        ],
      ),
    );
  }
}