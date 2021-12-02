
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

import 'package:partida/partida.dart';
import 'constantes.dart';
import 'repositorio_db.dart';
import 'usuario.dart';



class RepsitorioMongo extends RepositorioIdeal{
  late Db db;
  RepsitorioMongo(){}
  
  void inicializar() async{
    db = await Db.create(link);
  }

  @override
  Future<List<Partida>> recuperarPartidas({ required Usuario usuario}) async {
    List<Partida> partidas;
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.findOne(where.eq('nombre', usuario.nombre.toString()));
    await db.close();
    var res = val!.remove('_id');
    Usuario x = Usuario.fromMap(val);
    partidas = x.partidas;
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

  //previamente se se actualizo las partidas del usuario
  @override
  Future<bool> reescribirPartidas({required Usuario usuario}) async {
    bool check = false;
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    colexion.update(await colexion.findOne(where.eq('nombre', usuario.nombre.toString())),
    SetStage({
      'partidas': usuario.partidas,
    }).build()).then((value) => check = true);
    db.close();
    return check;
  } 
}

