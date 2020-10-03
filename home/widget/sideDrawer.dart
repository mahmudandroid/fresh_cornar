import 'dart:ui';

import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
               topRight: Radius.circular(50)),
          child: Container(
            // decoration: BoxDecoration(
            //gradient: SweepGradient(colors: [Colors.red, Colors.orange])),
            width: MediaQuery.of(context).size.width / 1.4,
            child: Drawer(
              elevation: 0.0,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: ListView(
                  padding: EdgeInsets.only(left: 15),
                  children: <Widget>[
                    AppBar(
                      iconTheme: IconThemeData(
                          color: Theme.of(context).scaffoldBackgroundColor),
                      backgroundColor: Theme.of(context).primaryColor,
                      title: Text(
                        "Fresh Corner",
                        style:
                        TextStyle(color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                    DrawerHeader(
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/profile.png"),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Mahire Zane",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                      Theme.of(context).iconTheme.color)),
                            ]),
                      ),
                    ),
                    ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.history,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        title: Text("Orders History",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color)),
                        onTap:
                            () {} /* => Navigator.of(context)
                    .pushReplacementNamed(OrderDetails.routeName),*/
                    ),
                    ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.favorite,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        title: Text("Favorites",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color)),
                        onTap:
                            () {} /* => Navigator.of(context)
                    .pushReplacementNamed(OrderDetails.routeName),*/
                    ),
                    ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.local_dining,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        title: Text("Products ",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color)),
                        onTap:
                            () {} /* => Navigator.of(context)
                    .pushReplacementNamed(OrderDetails.routeName),*/
                    ),
                    ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.loyalty,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        title: Text("Discounts",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color)),
                        onTap:
                            () {} /* => Navigator.of(context)
                    .pushReplacementNamed(OrderDetails.routeName),*/
                    ),
                    ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.person,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        title: Text("Your Profile",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color)),
                        onTap:
                            () {} /* => Navigator.of(context)
                    .pushReplacementNamed(OrderDetails.routeName),*/
                    ),
                    ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.lock,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        title: Text("Password Settings",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color)),
                        onTap:
                            () {} /* => Navigator.of(context)
                    .pushReplacementNamed(OrderDetails.routeName),*/
                    ),
                    ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.info,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        title: Text("About the app",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color)),
                        onTap:
                            () {} /* => Navigator.of(context)
                    .pushReplacementNamed(OrderDetails.routeName),*/
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
