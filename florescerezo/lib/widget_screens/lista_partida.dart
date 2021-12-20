import 'dart:math';

import 'package:florescerezo/bloc_ohanami/constantes.dart';
import 'package:florescerezo/db/db_helper.dart';
import 'package:florescerezo/widget_screens/display_stats.dart';
import 'package:florescerezo/widget_screens/vista_login.dart';
import 'package:florescerezo/widget_screens/vista_nuevapartida.dart';
import 'package:florescerezo/widget_screens/vista_registro.dart';
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
        print("Se guardaron las partidas exitosamente");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se guardaron las partidas exitosamente")));

      } else {
        bool check2 = await mongo.registrarUsuario(usuario: usuarioLocal);
        print("Se pudo mejor");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Es tu primera partida?")));

      }
    } else {
      print("No hay conexion");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No hay conexion a la nube")));

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
          color: Colors.white,
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
                  color: primaryColor,
                ),
                DrawerHeader(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ohanami_logo),
                    ),
                    color: primaryColor,
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
               
              ],
            ),
          )
        : CircularProgressIndicator();
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
          const Text("Error al obtener datos")
          :
          snapshot.data!.partidas.isEmpty ?
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                               SizedBox(
                  height: 20,
                ),
                 Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                   child: Container(margin: EdgeInsets.only(top: 200.0), child:Text("No tienes partidas guardadas", textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25, 
                      ),
                    
                    ),
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(cerezo),fit: BoxFit.cover,)),),
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
          int partida =index+1;
          int reverseIndex = snapshot.data!.partidas.length - 1 - index;
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
                  title:  Text('Partida '+partida.toString()),
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Iniciando..")));
            sincronizarDB();
          },
        ),
        ListTile(
          leading: Icon(Icons.logout,color: primaryTextColor,),
          title: Text("Cerrar sesion"),
          onTap: () => alertDialog(context),
        ),
      ],
    );
  }
  void alertDialog(BuildContext context) {
  var alert = AlertDialog(
      title: Text('¿Estas seguro de cerrar la sesion?'),
      content:
          Text("Se eliminarán todas las partidas que no estén en la nube"),
      actions: <Widget>[
        ElevatedButton(
            child: Text("Aceptar"),
            onPressed: () async {
              bool check = await local.eliminarUsuario();
            if (check == true) {
              print("Se elimino el usuario");
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  VistaLogin()));
            }),

        ElevatedButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
 showDialog(context: context, builder: (BuildContext context) => alert);
}

}