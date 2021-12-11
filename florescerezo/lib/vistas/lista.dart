
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/nuevapartida.dart';
import 'package:flutter/material.dart';
import 'package:db_paquete/db_paquete.dart';

class VistaListaPartidas extends StatefulWidget {
  const VistaListaPartidas({Key? key}) : super(key: key);

  @override
  VistaListaPartidasState createState() => VistaListaPartidasState();
}

class VistaListaPartidasState extends State<VistaListaPartidas> {
  RepositorioLocal local = RepositorioLocal();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_library_add_outlined),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute( builder: (context) => NuevaPartida() ));
          }
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text("Data"),
              ),
              ListTile(
                title: Text("Iniciar sesion"),
                onTap: (){

                },
              ),
              ListTile(
                title: Text("Registrarse"),
                onTap: (){
                  
                },
              ),
              ElevatedButton(
                onPressed:(){

                } , 
                child:Text("Sincronizar DB")
              ),
            ],
          ),
        ),
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
                      } 
                      else 
                      {
                        return ListView.builder(
                          itemCount: snapshot.data!.partidas.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.amber[600],
                              child:Center(
                                child: Column(
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
                }
            )
        ),
      ),
    );
  }
}