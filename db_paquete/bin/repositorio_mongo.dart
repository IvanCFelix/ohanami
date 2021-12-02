
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

import 'package:partida/partida.dart';
import 'constantes.dart';
import 'repositorio_db.dart';
import 'usuario.dart';



class RepsitorioMongo extends RepositorioIdeal{
  late Db db;
  late DbCollection colexion1;
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
  void registrarPartida({ required Partida p, required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var partidas = jsonDecode(p.toJson());
    List<Partida> lista = await recuperarPartidas(usuario: usuario);
    if (lista.isEmpty) {
    await colexion.update(await colexion.findOne(where.eq('nombre', usuario.nombre.toString())), 
    SetStage({
      'partidas': [partidas],
    }).build()
    );
    }
    await colexion.update(await colexion.findOne(where.eq('nombre', usuario.nombre.toString())), 
    AddToSet({
      'partidas': partidas,
    }).build()
    );
    db.close();
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
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    await colexion.insert(jsonDecode(usuario.toJson()));
    db.close();
    return true;
  }

  @override
  eliminarUsuario({required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.find(await colexion.remove(where.eq('nombre', usuario.nombre.toString())));
    return true;
  }


  @override
  Future<bool> verificarInicioSesion({required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var conexion = db.collection('usuarios');
    var val = await conexion.findOne(
      where.eq('nombre', usuario.nombre.toString()).and(where.eq('clave', usuario.clave.toString())));
    await db.close();
    if (val == null) {
      return false;
    }
    return true;
  }

  @override
  eliminarPartida({required Partida p, required Usuario usuario}) {
    // TODO: implement eliminarPartida
    throw UnimplementedError();
  }  
}

