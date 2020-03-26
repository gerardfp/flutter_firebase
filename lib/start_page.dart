import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/home_page.dart';
import 'package:flutter_firebase/login_page.dart';
import 'package:flutter_firebase/util.dart';


class StartPage extends StatefulWidget {
  @override
  createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  build(context) {
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  checkLogin() async {
    var user = await FirebaseAuth.instance.currentUser();

    if(user != null){
      navigateToPage(context, HomePage());
    } else {
      navigateToPage(context, LoginPage());
    }
  }
}
