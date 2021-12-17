
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
    bool consultar = false;
    try {
      await Db.create(link).then((value) => consultar = true);
    } on SocketException catch (_) {
      consultar = false;
    }
    return consultar;
  }
 
  @override
  Future<List<Partida>> recuperarPartidas({ required Usuario usuario}) async {
    List<Partida> partidas;
    db = await Db.create(link);
    await db.open();
    var coleccion = db.collection('usuarios');
    var respuesta = await coleccion.findOne(where.eq('nombre', usuario.nombre.toString()));
    await db.close();
    respuesta!.remove('_id');
    Usuario usuarioDB = Usuario.fromMap(respuesta);
    partidas = usuarioDB.partidas;
    print(partidas.toString());
    return partidas;
  }

  @override
  Future<bool> registrarPartida({ required Partida partida, required Usuario usuario}) async {
    bool consultar = false;
    List<Partida> lista = await recuperarPartidas(usuario: usuario);
    var partidas = jsonDecode(partida.toJson());
    db = await Db.create(link);
    await db.open();
    var coleccion = db.collection('usuarios');
    if (lista.isEmpty) {
      await coleccion.update(await coleccion.findOne(where.eq('nombre', usuario.nombre.toString())), 
      SetStage({
        'partidas': [partidas],
      }).build()).then((value) => consultar = true);
    }
    await coleccion.update(await coleccion.findOne(where.eq('nombre', usuario.nombre.toString())), 
      Push({'partidas': partidas}
        ).build()).then((value) => consultar = true);
    db.close();
    return consultar;
  }

  @override
  Future<bool> registradoUsuario({ required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var coleccion = db.collection('usuarios');
    var val = await coleccion.find(where.eq('nombre', usuario.nombre.toString())).toList();
    db.close();
    if (val.isEmpty) {
      return false; 
    }
    return true;
  }

  @override
  Future<bool> registrarUsuario({ required Usuario usuario}) async {
    bool consultar = false;
    db = await Db.create(link);
    await db.open();
    var coleccion = db.collection('usuarios');
    await coleccion.insert(jsonDecode(usuario.toJson())).then((value) => consultar = true);
    db.close();
    return consultar;
  }

  @override
  Future<bool> eliminarUsuario({required Usuario usuario}) async {
    bool consultar = false;
    db = await Db.create(link);
    await db.open();
    var coleccion = db.collection('usuarios');
    coleccion.find(await coleccion.remove(where.eq('nombre', usuario.nombre.toString())).then((value) => consultar = true));
    db.close();
    return consultar;
  }

  @override
  Future<bool> verificarInicioSesion({required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var coleccion = db.collection('usuarios');
    var respuesta = await coleccion.findOne(
      where.eq('nombre', usuario.nombre.toString()).and(where.eq('clave', usuario.clave.toString())));
    db.close();
    if (respuesta == null) {
      return false;
    }
    return true;
  }

    Future<bool> reescribirPartidas({required Usuario usuario}) async {
    bool consultar = false;
    List<Partida> partidas = usuario.partidas;

    var partidasJson = jsonDecode(json.encode(partidas.map((x) => x.toMap()).toList()));
    print(partidasJson);
    db = await Db.create(link);
    await db.open();
    var coleccion = db.collection('usuarios');
    await coleccion.updateOne(where.eq('nombre', usuario.nombre.toString()),
        modify.set('partidas', partidasJson));
    db.close();
    return consultar;
  }
  
  Future<Usuario> recuperarUsuario({ required Usuario usuario}) async {
    db = await Db.create(link);
    await db.open();
    var coleccion = db.collection('usuarios');
    var respuesta = await coleccion.findOne(where.eq('nombre', usuario.nombre.toString()));
    await db.close();
    respuesta!.remove('_id');
    Usuario usuarioDB = Usuario.fromMap(respuesta);
    return usuarioDB;
  }

  Future<bool> sincronizarUsuario({required Usuario usuario}) async{
    bool consultar = await eliminarUsuario(usuario: usuario);
    if (consultar == true) {
      bool consultar2 = await registrarUsuario(usuario: usuario);
      consultar = consultar2;
    }
    return consultar;
  }
}
