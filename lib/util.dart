import 'package:flutter/material.dart';

void navegarHacia(context, page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}