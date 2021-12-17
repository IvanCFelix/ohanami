import 'dart:math';

import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/detalle_partida.dart';
import 'package:florescerezo/vistas/login.dart';
import 'package:florescerezo/vistas/vista_nuevapartida.dart';
import 'package:florescerezo/vistas/registro.dart';
import 'package:flutter/material.dart';
import 'package:db_paquete/db_paquete.dart';
import 'package:partida/partida.dart';

import '../estilos.dart';

class VistaListaPartidas extends StatefulWidget {
  const VistaListaPartidas({Key? key}) : super(key: key);

  @override
  VistaListaPartidasState createState() => VistaListaPartidasState();
}

class VistaListaPartidasState extends State<VistaListaPartidas> {
  RepositorioLocal local = RepositorioLocal();
  late Future<Usuario> usuario;

  @override
  void initState() {
    usuario = local.recuperarUsuario();
    super.initState();
  }

  void sincronizarDB() async {
    RepositorioLocal local = RepositorioLocal();
    RepositorioMongo mongo = RepositorioMongo();
    Usuario usuarioLocal = await local.recuperarUsuario();
    bool check = await mongo.inicializar();
    if (check == true) {
      check = await mongo.registradoUsuario(usuario: usuarioLocal);
      if (check == true) {
        bool checo = await mongo.reescribirPartidas(usuario: usuarioLocal);
        print("Si se pudo");
      } else {
        bool check2 = await mongo.registrarUsuario(usuario: usuarioLocal);
        print("Se pudo mejor");
      }
    } else {
      print("No hay conexion");
    }
  }

  _imagenAleatoria(){
    var rng = new Random();
    int numero = rng.nextInt(3);
    switch (numero) {
      case 0: return Image.network("https://static.wikia.nocookie.net/monster-strike-enjp/images/6/6e/3279.png/revision/latest/scale-to-width-down/398?cb=20180401003316");
      case 1: return Image.network("https://i.pinimg.com/originals/a0/50/92/a050921c3b4d7372b6fc77254c9ab283.jpg");
      case 2: return Image.network("https://i.pinimg.com/564x/ea/fa/e2/eafae27c83386418a8ed895e02a23c8c.jpg");
      case 3: return Image.network("https://i.pinimg.com/originals/bf/bd/db/bfbddb3f4810e2bc608ff2c86e64817c.jpg");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryDarkColor,
        child: const Icon(
          Icons.my_library_add_outlined,
          color: secondaryTextColor,
        ),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const Vista_NuevaPartida()));
            }
      ),
      drawer: FutureBuilder(
        future: usuario,
        builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
          return snapshot.hasData ? snapshot.hasError ? 
          const Text("Error")
          : Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 24,
                  color: secondaryDarkColor,
                ),
                DrawerHeader(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("http://mercurio.com.es/images/cabecero_ohanami_2018.jpg?crc=391650972"),
                    ),
                    color: secondaryDarkColor,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(snapshot.data!.nombre.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    ),
                  ), 
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                snapshot.data!.nombre.isNotEmpty ?
                _sesion()

                : 

                _registro(),
                 const Divider(
                  height: 1,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.network("http://mercurio.com.es/images/logo-mercurio-2015-u357336.png?crc=113239139")
              ],
            ),
          )

        //Lista /* */
        : CircularProgressIndicator();
        // cargando
        },
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: FutureBuilder<Usuario>(
        future: local.recuperarUsuario(),
        builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
          return snapshot.hasData ?
          snapshot.hasError ?
          const Text("error al obtener datos")
          :
          snapshot.data!.partidas.isEmpty ?
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _imagenAleatoria(),
                //Image.network("https://static.wikia.nocookie.net/monster-strike-enjp/images/6/6e/3279.png/revision/latest/scale-to-width-down/398?cb=20180401003316"),
                SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Text("No tienes partidas guardadas",
                        style: TextStyle(
                          fontSize: 25,
                      )
                    ),
                  ),
                ),
              ],
            ),
          )
          :
          _listaDatos(snapshot)
          :
          const CircularProgressIndicator();
        }
      )
    ),
  );
}
  _listaDatos(snapshot) {
    return ListView.builder(
        itemCount: snapshot.data!.partidas.length,
        itemBuilder: (BuildContext context, int index) {
          int reverseIndex = snapshot.data!.partidas.length - 1 - index;
          print(reverseIndex);
          FasePuntuacion.Ronda1;
          FasePuntuacion.Ronda2;
          FasePuntuacion.Ronda3;
          snapshot.data!.partidas[0].puntos(ronda: FasePuntuacion.Ronda1);
          List<String> nombres = [];
          for (var i = 0;
              i < snapshot.data!.partidas[reverseIndex].jugadores.length;
              i++) {
            nombres.add(snapshot.data!.partidas[reverseIndex].jugadores
                .elementAt(i)
                .nombre
                .toString());
          }
          do {
            nombres.add("");
          } while (nombres.length < 4);

          return Card(
            elevation: 10.0,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.auto_awesome),
                  title: const Text('Nombre de la partida (Opcional)'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jugadores',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      Text(nombres[0]),
                      Text(nombres[1]),
                      Text(nombres[2]),
                      Text(nombres[3]),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetallePartida(
                                    partida: snapshot
                                        .data!.partidas[reverseIndex])));
                      },
                      child: const Text('Ver Partida'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // print(index);
                        await local
                            .eliminarPartida(indice: reverseIndex)
                            .whenComplete(() {
                          setState(() {
                            snapshot.data!.partidas.removeAt(reverseIndex);
                          });
                        });
                      },
                      child: const Text('Eliminar partida'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      );
  }

  _registro(){
return ListTile(
  enableFeedback: true,
  title: const Text("Registrarse",
  style: TextStyle(
    fontSize: 15
  ),
  ),
  leading: const Icon(
    Icons.person_add,
    color: secondaryDarkColor,
  ),
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const VistaRegistro()));
  },
  );
}

  _sesion(){
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.cloud_upload),
          title: Text("Guardar partidas en la nube"),
          onTap: () async {
            sincronizarDB();
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  VistaLogin()));
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Cerrar sesion"),
          onTap: () async {
            print("Estas seguro de eliminar el usuario");
            print("Se eliminara todo si no sincronizaste al db");
            bool check = await local.eliminarUsuario();
            if (check == true) {
              print("Se elimino el usuario");
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  VistaLogin()));
          },
        ),
      ],
    );
  }
}