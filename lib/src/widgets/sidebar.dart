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
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.all_inclusive),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Genre', style: TextStyle(fontSize: 16.0),),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_drop_down)
                ]
              ),
            )
          ),
        ]
      ),
    );
  }
}
