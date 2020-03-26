import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/register_page.dart';

import 'home_page.dart';
import 'util.dart';


class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var errorMessage = "";
  var logueando = false;

  @override
  build(context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text("LOGIN"),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value.isEmpty) return 'Please enter your email';
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value.isEmpty) return 'Please enter your password';
                return null;
              },
            ),
            RaisedButton(
              onPressed: logueando ? null : () async {
                if (_formKey.currentState.validate()) _signInWithEmailAndPassword();
              },
              child: const Text('Login'),
            ),
            GestureDetector(
              onTap: () => navigateToPage(context, RegisterPage()),
              child: Text("Don't have an account, register"),
            ),
            _buildErrorMessage()
          ],
        ),
      ),
    );
  }

  _signInWithEmailAndPassword() async {
    setState(() {
      logueando = true;
    });

    try {
      final user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )).user;

      if (user != null) navigateToPage(context, HomePage());
    } catch(e) {
      setState(() {
        errorMessage = e.message;
        logueando = false;
      });
    }
  }

  _buildErrorMessage() {
    if (errorMessage.length > 0 && errorMessage != null)
      return Text(
        errorMessage,
        style: TextStyle(
          color: Colors.red,
        ),
      );

    return Container(
      height: 0.0,
    );
  }
}