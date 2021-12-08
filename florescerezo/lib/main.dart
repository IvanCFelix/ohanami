import 'package:florescerezo/vistas/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ohanami',
      home: VistaLogin(),
    );
  }
}