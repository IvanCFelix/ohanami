import 'dart:async';

import 'package:florescerezo/db_local.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:db_paquete/db_paquete.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SharedPreferences Demo',
      home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({Key? key}) : super(key: key);

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;
  late Future<Usuario> _usuario; 
  RepositorioLocal dbL = RepositorioLocal();

  @override
  void initState() {
    super.initState();
    _usuario = dbL.regresarUsuario();
    print(_usuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Demo'),
      ),
      body: Center(
          child: FutureBuilder<Usuario>(
              future: _usuario,
              builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Column(
                        children: [
                          Text(
                             snapshot.data!.nombre.toString()
                          ),
                          Text(
                             snapshot.data!.telefono.toString()
                          ),
                          Text(
                             snapshot.data!.clave.toString()
                          ),
                          Text(
                             snapshot.data!.partidas[0].toString()
                          ),
                        ],
                      );
                    }
                }
              }
              )
              ),
    );
  }
}
