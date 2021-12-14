import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/detalle_partida.dart';
import 'package:florescerezo/vistas/login.dart';
import 'package:florescerezo/vistas/nuevapartida.dart';
import 'package:florescerezo/vistas/registro.dart';
import 'package:flutter/material.dart';
import 'package:db_paquete/db_paquete.dart';
import 'package:partida/partida.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.my_library_add_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NuevaPartida()));
            }),
        drawer: FutureBuilder(
          future: usuario,
          builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
            return snapshot.hasData
                ? snapshot.hasError
                    ? Text("Error")
                    // vista error
                    : Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            DrawerHeader(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Text(snapshot.data!.nombre.toString()),
                            ),
                            snapshot.data!.nombre.isNotEmpty
                                ? Column(
                                    children: [
                                      ListTile(
                                        title: Text("Cerrar Sesion"),
                                        onTap: () async {
                                          print(
                                              "Estas seguro de eliminar el usuario");
                                          print(
                                              "Se eliminara todo si no sincronizaste al db");
                                          bool check =
                                              await local.eliminarUsuario();
                                          if (check == true) {
                                            print("Se elimino el usuario");
                                          }
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const VistaLogin()));
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              sincronizarDB();
                                            },
                                            child: Text("Sincronizar DB")),
                                      ),
                                    ],
                                  )
                                : ListTile(
                                    title: Text("Registrarse"),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VistaRegistro()));
                                    },
                                  ),
                          ],
                        ),
                      )
                //Lista
                : CircularProgressIndicator();
            // cargando
          },
        ),
        appBar: AppBar(),
        body: Center(
            child: FutureBuilder<Usuario>(
                future: local.recuperarUsuario(),
                builder:
                    (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                  return snapshot.hasData
                      ?
                      // data SÍ, entonces
                      // preguntar si tiene error
                      snapshot.hasError
                          ?
                          // error sí
                          // vista error
                          Text("error al obtener datos")
                          :
                          // error no
                          // vista lista
                          snapshot.data!.partidas.isEmpty
                              ?
                              // data sí, pero
                              // está vacía
                              Text("no hay partidas")
                              :
                              // data sí, pero
                              // tiene datos
                              _listaDatos(snapshot)
                      :
                      // data NO, entonces
                      // vista cargando
                      const CircularProgressIndicator();
                })),
      ),
    );
  }

  _listaDatos(snapshot) {
    return ListView.builder(
        itemCount: snapshot.data!.partidas.length,
        itemBuilder: (BuildContext context, int index) {
          int reverseIndex = snapshot.data!.partidas.length - 1 - index;
          print(reverseIndex); // verificador
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
        });
  }
}