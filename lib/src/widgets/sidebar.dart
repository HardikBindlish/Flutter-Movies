import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget{
  Widget build(context){
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Side Menu', style: TextStyle(fontSize: 25.0, color: Colors.black)),
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/sidebar_pic.png'),
                fit: BoxFit.fill
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.all_inclusive),
            title: Text('All Genre'),
            onTap: () => {},
          ),
        ]
      ),
    );
  }
}