import 'package:flutter/material.dart';
import 'package:flutterdatapersistence/daos/user_dao.dart';
import 'package:flutterdatapersistence/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RetrieveDetails extends StatefulWidget {
  @override
  _RetrieveDetailsState createState() => _RetrieveDetailsState();
}

class _RetrieveDetailsState extends State<RetrieveDetails> {
  String name = "Dummy";

  @override
  void initState() {
    // uncomment to fetch from SF

    /*
    // fetch user name from Shared Preferences
    fetchUserNameFromSF();
    */

    // fetch user from DB
    fetchUserNameFromDB();

    super.initState();
  }

  // fetch user from db
  fetchUserNameFromDB() async {
    User user = await UserDao().fetchUserByEmail('johndoe@mail.com');

    if (user != null) {
      setState(() {
        name = user.name;
      });
    }
  }

/*
  fetchUserNameFromSF() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String fetchedName = preferences.getString('username') ?? null;

    if (fetchedName != null) {
      setState(() {
        name = fetchedName;
      });
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text('My name is $name')],
        ),
      )),
    );
  }
}
