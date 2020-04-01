import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'util.dart';

import 'pagina_registro.dart';
import 'pagina_hogar.dart';


class PaginaAcceso extends StatefulWidget {
  @override
  createState() => _PaginaAccesoState();
}

class _PaginaAccesoState extends State<PaginaAcceso> {
  final _keyFormulario = GlobalKey<FormState>();
  final _controladorEmail = TextEditingController();
  final _controladorPasswd = TextEditingController();
  var _mensajeError = "";
  var _accediendo = false;

  _loguearConEmailYPassword() async {
    setState(() {
      _accediendo = true;
    });

    try {
      final usuario = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controladorEmail.text,
        password: _controladorPasswd.text,
      )).user;

      if (usuario != null) navegarHacia(context, PaginaHogar());
    } catch(e) {
      setState(() {
        _mensajeError = e.message;
        _accediendo = false;
      });
    }
  }

  @override
  build(context) {
    return Scaffold(
      body: Form(
        key: _keyFormulario,
        child: ListView(
          children: [
            Text("ACCESO"),
            TextFormField(
              controller: _controladorEmail,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value.isEmpty) return 'Por favor introduzca su email';
                return null;
              },
            ),
            TextFormField(
              controller: _controladorPasswd,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value.isEmpty) return 'Por favor introduzca su password';
                return null;
              },
            ),
            RaisedButton(
              onPressed: _accediendo ? null : () async {
                if (_keyFormulario.currentState.validate()) _loguearConEmailYPassword();
              },
              child: const Text('Acceder'),
            ),
            GestureDetector(
              onTap: () => navegarHacia(context, RegisterPage()),
              child: const Text("No tienes una cuenta? Regístrate!"),
            ),
            buildMensajeDeError()
          ],
        ),
      ),
    );
  }



  buildMensajeDeError() {
    if (_mensajeError.length > 0 && _mensajeError != null)
      return Text(
        _mensajeError,
        style: TextStyle(
          color: Colors.red,
        ),
      );

    return Container(
      height: 0.0,
    );
  }
}