import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'util.dart';

import 'pagina_hogar.dart';
import 'pagina_acceso.dart';


class PaginaInicio extends StatefulWidget {
  @override
  createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {

  @override
  void initState() {
    super.initState();
    _comprobarLogin();
  }

  _comprobarLogin() async {
    var usuario = await FirebaseAuth.instance.currentUser();

    if(usuario != null){
      navegarHacia(context, PaginaHogar());
    } else {
      navegarHacia(context, PaginaAcceso());
    }
  }

  @override
  build(context) {
    return Scaffold(
      body: const CircularProgressIndicator(),
    );
  }
}
