import 'package:flutter/material.dart';

void navigateToPage(context, page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}