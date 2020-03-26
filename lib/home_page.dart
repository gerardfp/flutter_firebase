import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/start_page.dart';

import 'util.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var email = "anoymous";

  @override
  initState() {
    super.initState();

    getUserEmail();
  }

  @override
  build(context) => Scaffold(
    body: Column(
      children: <Widget>[
        Text("WELCOME ${email}!"),
        RaisedButton(
          onPressed: () => { signOut() },
          child: Text("Sign out"),
        )
      ],
    ),
  );

  getUserEmail() async {
    var user = await FirebaseAuth.instance.currentUser();

    if(user != null){
      setState(() {
        this.email = user.email;
      });
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    navigateToPage(context, StartPage());
  }
}