import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'util.dart';

import 'pagina_hogar.dart';


class RegisterPage extends StatefulWidget {
  @override
  createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _keyFormulario = GlobalKey<FormState>();
  final _controladorEmail = TextEditingController();
  final _controladorPasswd = TextEditingController();

  _registrarConEmailYPasswd() async {
    final usuario = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _controladorEmail.text,
      password: _controladorPasswd.text,
    )).user;

    if (usuario != null) navegarHacia(context, PaginaHogar());
  }

  @override
  build(context) {
    return Scaffold(
      body: Form(
        key: _keyFormulario,
        child: ListView(
          children: [
            const Text("REGISTRO"),
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
              onPressed: () async {
                if (_keyFormulario.currentState.validate()) _registrarConEmailYPasswd();
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}