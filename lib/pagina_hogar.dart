import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'util.dart';

import 'pagina_inicio.dart';
import 'pagina_crear.dart';


class PaginaHogar extends StatefulWidget {
  @override
  createState() => _PaginaHogarState();
}

class _PaginaHogarState extends State<PaginaHogar> {
  var _email = "anoymous";

  @override
  initState() {
    super.initState();

    _obtenerEmailLogueado();
  }

  _obtenerEmailLogueado() async {
    var usuario = await FirebaseAuth.instance.currentUser();

    if(usuario != null){
      setState(() {
        this._email = usuario.email;
      });
    }
  }

  _cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    navegarHacia(context, PaginaInicio());
  }

  @override
  build(context) => Scaffold(
    appBar: AppBar(
      title: Text("${_email}"),
      actions: <Widget>[
        IconButton(
          onPressed: _cerrarSesion,
          icon: const Icon(Icons.exit_to_app),
        )
      ],
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        navegarHacia(context, PaginaCrear());
      },
    ),
    body: StreamBuilder(
      stream: Firestore.instance.collection("books").snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError)
          return Text('Error: ${snapshot.error}');

        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                var book = snapshot.data.documents.elementAt(index);
                return ListTile(
                  leading: book['imagenURL'] != null ? Image.network(book['imagenURL']) : const Icon(Icons.image),
                  title: Text(book['titulo']),
                );
              },
            );
        }
      },
    )
  );
}