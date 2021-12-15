
import 'dart:convert';
import 'dart:io';
import 'package:db_paquete/src/repositorio_.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:partida/partida.dart';
import 'constantes.dart';
import 'usuario.dart';

class RepositorioMongo extends Repositorio {
  late Db db;
  RepositorioMongo(){}
  
  Future<bool> inicializar() async{
  bool check = false;
  try {
    await Db.create(link).then((value) => check = true);
  } on SocketException catch (_) {
    check = false;
  }
    return check;
  }
 
  @override
  Future<List<Partida>> recuperarPartidas({ required Usuario usuario}) async {
    List<Partida> partidas;
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.findOne(where.eq('nombre', usuario.nombre.toString()));
    await db.close();
    val!.remove('_id');
    Usuario x = Usuario.fromMap(val);
    partidas = x.partidas;

    print(partidas.toString());
    return partidas;
  }

  @override
  Future<bool> registrarPartida({ required Partida partida, required Usuario usuario}) async {
    bool check = false;
    List<Partida> lista = await recuperarPartidas(usuario: usuario);
    var partidas = jsonDecode(partida.toJson());
    var index = lista.length;
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
  
    if (lista.isEmpty) {
    await colexion.update(await colexion.findOne(where.eq('nombre', usuario.nombre.toString())), 
    SetStage({
      'partidas': [partidas],
    }).build()).then((value) => check = true);
    }
    await colexion.update(await colexion.findOne(where.eq('nombre', usuario.nombre.toString())), 
    Push({'partidas': partidas}
      ).build()).then((value) => check = true);
    db.close();

    return check;
  }
  ///pantalla para registrar usuario
  @override
  Future<bool> registradoUsuario({ required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.find(where.eq('nombre', usuario.nombre.toString())).toList();
    db.close();
    if (val.isEmpty) {
      return false; 
    }
    return true;
  }
  //despues del de arriba
  @override
  Future<bool> registrarUsuario({ required Usuario usuario}) async {
    bool check = false;
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    await colexion.insert(jsonDecode(usuario.toJson())).then((value) => check = true);
    db.close();
    return check;
  }

  @override
  Future<bool> eliminarUsuario({required Usuario usuario}) async {
    bool check = false;
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    colexion.find(await colexion.remove(where.eq('nombre', usuario.nombre.toString())).then((value) => check = true));
    db.close();
    return check;
  }

  @override
  Future<bool> verificarInicioSesion({required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var conexion = db.collection('usuarios');
    var val = await conexion.findOne(
      where.eq('nombre', usuario.nombre.toString()).and(where.eq('clave', usuario.clave.toString())));
    db.close();
    if (val == null) {
      return false;
    }
    return true;
  }

  //previamente se actualizo las partidas del usuario
  

    Future<bool> reescribirPartidas({required Usuario usuario}) async {
    bool check = false;
    List<Partida> partidas = usuario.partidas;

    var partidasJson2 = jsonDecode(json.encode(partidas.map((x) => x.toMap()).toList()));

    print(partidasJson2);

    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    await colexion.updateOne(where.eq('nombre', usuario.nombre.toString()),
        modify.set('partidas', partidasJson2));

    db.close();
    return check;
  }
  
  Future<Usuario> recuperarUsuario({ required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.findOne(where.eq('nombre', usuario.nombre.toString()));
    await db.close();
    val!.remove('_id');
    Usuario x = Usuario.fromMap(val);
    return x;
  }

  Future<bool> sincronizarUsuario({required Usuario usuario}) async{
    bool check = await eliminarUsuario(usuario: usuario);
    if (check == true) {
     bool check2 = await registrarUsuario(usuario: usuario);
     check = check2;
    }
    return check;
  }
}