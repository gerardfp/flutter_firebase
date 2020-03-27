import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'util.dart';

import 'home_page.dart';


class RegisterPage extends StatefulWidget {
  @override
  createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final keyFormulario = GlobalKey<FormState>();
  final controladorEmail = TextEditingController();
  final controladorPasswd = TextEditingController();

  @override
  build(context) {
    return Scaffold(
      body: Form(
        key: keyFormulario,
        child: ListView(
          children: [
            Text("REGISTRO"),
            TextFormField(
              controller: controladorEmail,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value.isEmpty) return 'Por favor introduzca su email';
              },
            ),
            TextFormField(
              controller: controladorPasswd,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value.isEmpty) return 'Por favor introduzca su password';
              },
            ),
            RaisedButton(
              onPressed: () async {
                if (keyFormulario.currentState.validate()) registrar();
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  registrar() async {
    final usuario = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: controladorEmail.text,
      password: controladorPasswd.text,
    )).user;

    if (usuario != null) navegarHacia(context, PaginaHogar());
  }
}