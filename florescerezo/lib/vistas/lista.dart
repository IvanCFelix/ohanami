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
    //local.eliminarUsuario();
    //_counter =  local.recuperarUsuario() ;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        ),
        body: Center(
            child: FutureBuilder<Usuario>(
                future: local.recuperarUsuario(),
                builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                  
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    default:
                      if (snapshot.data!.partidas.length == 0) {
                        return Text("No hay partidas");
                      } else {
                        return ListView.builder(
                              itemCount: snapshot.data!.partidas.length,
                              itemBuilder: (BuildContext context, int index) {
                              return Card(
                                      color: Colors.amber[600],
                                      child:Center(child: Column(
                                        children: [
                                          Text(snapshot.data!.partidas[index].jugadores.toString()),
                                        ]
                                      ),
                                      )
                                      );
                            }    
                        );

                      }
                  }
                })),
      ),
    );
  }
}