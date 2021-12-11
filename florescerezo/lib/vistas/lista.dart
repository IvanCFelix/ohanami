import 'dart:async';
import 'package:florescerezo/db/db_local.dart';
import 'package:flutter/material.dart';
import 'package:db_paquete/db_paquete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VistaListaPartidas extends StatefulWidget {
  const VistaListaPartidas({Key? key}) : super(key: key);

  @override
  VistaListaPartidasState createState() => VistaListaPartidasState();
}

class VistaListaPartidasState extends State<VistaListaPartidas> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RepositorioLocal local = RepositorioLocal();
  late Future<Usuario> _counter;


  @override
  void initState() {
    super.initState();
    _counter =  local.recuperarUsuario()as Future<Usuario> ;
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
                        return ListView.builder(
                          itemCount: snapshot.data!.partidas.length,
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(
                              title: Text(snapshot.data!.partidas[index].toString()),
                            );
                          },
                          );
                      }
                  }
                })),
      ),
    );
  }
}