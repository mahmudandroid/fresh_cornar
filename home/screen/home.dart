import "package:flutter/material.dart";
import 'package:fresh_cornar/home/widget/sideDrawer.dart';
class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int selectedIndex = 0;
  final widgetOptions = [
    Text("home"),
    Text("whatever"),
    Text("notification"),
    Text("profile"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: null,
          ),
        ],
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 2.0,
        shape: CircularNotchedRectangle(),
        child: Container(
          color: Colors.white,
          child: BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme:
            IconThemeData(color: Theme.of(context).primaryColor),
            unselectedItemColor: Colors.black38,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.dvr), title: Text("")),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Icon(Icons.offline_bolt)),
                  title: Text("")),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Icon(Icons.account_balance)),
                  title: Text("")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), title: Text("")),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: onItemTapped,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        onPressed: () {},
        tooltip: 'Increment',
        child: new Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
