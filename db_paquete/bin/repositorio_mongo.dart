
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

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
  Future<List<Partida>> recuperarPartidas({ required Usuario u}) async {
    List<Partida> partidas;
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.findOne(where.eq('nombre', u.nombre.toString()));
    await db.close();
    var res = val!.remove('_id');
    Usuario x = Usuario.fromMap(val);
    partidas = x.partidas;
    return partidas;
  }

  @override
  void registrarPartida({ required Partida p, required Usuario u}) async {
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var partidas = jsonDecode(p.toJson());
    List<Partida> lista = await recuperarPartidas(u: u);
    if (lista.isEmpty) {
    await colexion.update(await colexion.findOne(where.eq('nombre', u.nombre.toString())), 
    SetStage({
      'partidas': [partidas],
    }).build()
    );
    }
    await colexion.update(await colexion.findOne(where.eq('nombre', u.nombre.toString())), 
    AddToSet({
      'partidas': partidas,
    }).build()
    );
    db.close();
  }
  ///pantalla para registrar usuario
  @override
  Future<bool> registradoUsuario({ required Usuario u}) async {
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.find(where.eq('nombre', u.nombre.toString())).toList();
    db.close();
    if (val.isEmpty) {
      return false; 
    }
    return true;
  }
  //despues del de arriba
  @override
  Future<bool> registrarUsuario({ required Usuario u}) async {
    db = await Db.create(link);
    await db.open();
    var colexion = db.collection('usuarios');
    await colexion.insert(jsonDecode(u.toJson()));
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
  verificarInicioSesion({required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var conexion = db.collection('usuarios');
    var val = await conexion.findOne(
      where.eq('nombre', 'pedro').and(where.eq('clave', usuario.clave.toString())));
    await db.close();
    //var res = val!.remove('_id');
    print(val);
    //Usuario x = Usuario.fromMap(val);

    /*
    var armando = await conexion.find(where.eq('nombre', 'jose'));
    var res = armando.remove('_id');
    print(armando.isEmpty);
    */
    /*
    var val = await conexion.find(
      await conexion.find(
        where.eq('nombre', usuario.nombre.toString()).and(where.eq('clave', usuario.clave.toString()))));
    print(val);
    */
  }  
}

