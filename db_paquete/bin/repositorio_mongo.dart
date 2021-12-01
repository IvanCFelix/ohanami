
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'package:partida/partida.dart';
import 'repositorio_db.dart';
import 'usuario.dart';



class RepsitorioMongo extends RepositorioIdeal{
  late Db db;
  late DbCollection colexion1;
  RepsitorioMongo(){}
  
  void inicializar() async{
    db = await Db.create('mongodb+srv://root:root@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
    await db.open();
    colexion1 = db.collection('usuarios');
    print('object');
  }

  @override
  Future<List<Partida>> recuperarPartidas({ required Usuario u}) async {
    List<Partida> partidas;
    db = await Db.create('mongodb+srv://root:root@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.findOne(where.eq('nombre', u.nombre.toString()));
    //await db.close();
    var res = val!.remove('_id');
    Usuario x = Usuario.fromMap(val);
    partidas = x.partidas;
    return partidas;
  }

  @override
  void registrarPartida({ required Partida p, required Usuario u}) async {
    db = await Db.create('mongodb+srv://root:root@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
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
  }

  @override
  Future<bool> registradoUsuario({ required Usuario u}) async {
    db = await Db.create('mongodb+srv://root:root@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.find(where.eq('nombre', u.nombre.toString())).toList();
    //db.close();
    if (val.isEmpty) {
      return false; 
    }
    return true;
  }

  @override
  Future<bool> registrarUsuario({ required Usuario u}) async {
    db = await Db.create('mongodb+srv://root:root@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
    await db.open();
    var colexion = db.collection('usuarios');
    await colexion.insert(jsonDecode(u.toJson()));
    //db.close();
    return true;
  }

}

