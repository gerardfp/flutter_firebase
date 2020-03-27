import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'util.dart';

import 'register_page.dart';
import 'home_page.dart';


class PaginaAcceso extends StatefulWidget {
  @override
  createState() => _PaginaAccesoState();
}

class _PaginaAccesoState extends State<PaginaAcceso> {
  final keyFormulario = GlobalKey<FormState>();
  final controladorEmail = TextEditingController();
  final controladorPasswd = TextEditingController();
  var mensajeError = "";
  var accediendo = false;

  @override
  build(context) {
    return Scaffold(
      body: Form(
        key: keyFormulario,
        child: ListView(
          children: [
            Text("ACCESO"),
            TextFormField(
              controller: controladorEmail,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value.isEmpty) return 'Por favor introduzca su email';
                return null;
              },
            ),
            TextFormField(
              controller: controladorPasswd,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value.isEmpty) return 'Por favor introduzca su password';
                return null;
              },
            ),
            RaisedButton(
              onPressed: accediendo ? null : () async {
                if (keyFormulario.currentState.validate()) loguearseConEmailYPassword();
              },
              child: const Text('Acceder'),
            ),
            GestureDetector(
              onTap: () => navegarHacia(context, RegisterPage()),
              child: Text("No tienes una cuenta? Regístrate!"),
            ),
            construirMensajeDeError()
          ],
        ),
      ),
    );
  }

  loguearseConEmailYPassword() async {
    setState(() {
      accediendo = true;
    });

    try {
      final usuario = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controladorEmail.text,
        password: controladorPasswd.text,
      )).user;

      if (usuario != null) navegarHacia(context, PaginaHogar());
    } catch(e) {
      setState(() {
        mensajeError = e.message;
        accediendo = false;
      });
    }
  }

  construirMensajeDeError() {
    if (mensajeError.length > 0 && mensajeError != null)
      return Text(
        mensajeError,
        style: TextStyle(
          color: Colors.red,
        ),
      );

    return Container(
      height: 0.0,
    );
  }
}