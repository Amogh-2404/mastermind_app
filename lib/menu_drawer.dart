import 'package:flutter/material.dart';

const IconData person = IconData(0xe491, fontFamily: 'MaterialIcons');
const IconData password = IconData(0xe47a, fontFamily: 'MaterialIcons');
const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Mastermind',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.scatter_plot_sharp,color: Theme.of(context).appBarTheme.backgroundColor),
            title: Text('Statistics',style: TextStyle(color: Theme.of(context).appBarTheme.backgroundColor),),
            hoverColor: Theme.of(context).hoverColor,

            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Additional actions can be added here for navigation
            },
          ),

        ],
      ),
    );
  }
}