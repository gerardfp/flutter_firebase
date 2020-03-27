import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'util.dart';

import 'home_page.dart';
import 'login_page.dart';


class PaginaInicio extends StatefulWidget {
  @override
  createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {

  @override
  void initState() {
    super.initState();
    comprobarLogin();
  }

  @override
  build(context) {
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  comprobarLogin() async {
    var usuario = await FirebaseAuth.instance.currentUser();

    if(usuario != null){
      navegarHacia(context, PaginaHogar());
    } else {
      navegarHacia(context, PaginaAcceso());
    }
  }
}
