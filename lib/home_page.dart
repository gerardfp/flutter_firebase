import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'util.dart';

import 'start_page.dart';


class PaginaHogar extends StatefulWidget {
  @override
  createState() => _PaginaHogarState();
}

class _PaginaHogarState extends State<PaginaHogar> {
  var email = "anoymous";

  @override
  initState() {
    super.initState();

    obtenerEmailLogueado();
  }

  @override
  build(context) => Scaffold(
    body: Column(
      children: <Widget>[
        Text("WELCOME ${email}!"),
        RaisedButton(
          onPressed: cerrarSesion,
          child: Text("Cerrar sesión"),
        )
      ],
    ),
  );

  obtenerEmailLogueado() async {
    var usuario = await FirebaseAuth.instance.currentUser();

    if(usuario != null){
      setState(() {
        this.email = usuario.email;
      });
    }
  }

  cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    navegarHacia(context, PaginaInicio());
  }
}