import 'dart:async';

import 'package:florescerezo/db/db_local.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:db_paquete/db_paquete.dart';

class VistaListaPartidas extends StatefulWidget {
  const VistaListaPartidas({Key? key}) : super(key: key);

  @override
  VistaListaPartidasState createState() => VistaListaPartidasState();
}

class VistaListaPartidasState extends State<VistaListaPartidas> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;
  late Future<Usuario> _usuario; 
  RepositorioLocal dbL = RepositorioLocal();
  final ScrollController _firstController = ScrollController();

  @override
  void initState() {
    super.initState();
    _usuario =dbL.recuperarUsuario();
    print(_usuario);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        /*
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AgregarPartida()));
          */
      }
      ),
      appBar: AppBar(
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: <Widget>[
          Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ingrese un usuario',

                      ),
                    ),
                  ),
                  Center(
                    child: FutureBuilder<Usuario>(
                        future: _usuario,
                        builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                          return Text('No cuenta con ninguna partida creada ');
                        } 
                        else 
                        {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxWidth,
                            child: Scrollbar(
                              isAlwaysShown: true,
                              controller: _firstController,
                              child: ListView.builder(
                              controller: _firstController,
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
                        ),
                        ),
                          );

                        }
                }
              }
              ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(5.0),
                            primary: Colors.black,
                            textStyle: const TextStyle(fontSize: 10),
                            ),
                            onPressed: () {
                                            
                            },
                            child: const Text('Random'),
                        ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 10),
                        ),
                        onPressed: () {
                                        
                        },
                        child: const Text('Actualizar dbMongo'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 10),
                        ),
                        onPressed: () {
                          dbL.eliminarUsuario();
                                        
                        },
                        child: const Text('Eliminar U'),
                      ), 
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }
      )
    );
  }
}
