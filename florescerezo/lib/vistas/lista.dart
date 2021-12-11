import 'dart:async';
import 'package:florescerezo/db/db_local.dart';
import 'package:flutter/material.dart';
import 'package:db_paquete/db_paquete.dart';

class VistaListaPartidas extends StatefulWidget {
  const VistaListaPartidas({Key? key}) : super(key: key);

  @override
  VistaListaPartidasState createState() => VistaListaPartidasState();
}

class VistaListaPartidasState extends State<VistaListaPartidas> {
  RepositorioLocal local = RepositorioLocal();
  late Future<Usuario> _counter;


  @override
  void initState() {
    super.initState();
    _counter = local.recuperarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        ),
        body: Center(
            child: FutureBuilder<Usuario>(
                future: _counter,
                builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(snapshot.data!.nombre.toString(),
                        );
                      }
                  }
                })),
      ),
    );
  }
}