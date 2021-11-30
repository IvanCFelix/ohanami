import 'package:mongo_dart/mongo_dart.dart';

import 'package:partida/partida.dart';
import 'repositorio_db.dart';
import 'usuario.dart';



class RepsitorioMongo extends RepositorioIdeal{
  late Db db;
  RepsitorioMongo(){}
  
  void inicializar() async{
    
    db = await Db.create('mongodb+srv://root:root@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
    await db.open();
    print('object');
  }

  @override
  Future<List<Partida>> recuperarPartidas({ required Usuario u}) async {
    db = await Db.create('mongodb+srv://root:root@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
    await db.open();
    var colexion = db.collection('usuarios');
    var val = await colexion.findOne(where.eq('nombre', u.nombre.toString()));
    var res = val!.remove('_id');
    Usuario x = Usuario.fromMap(val);
    List<Partida> partidas;
    partidas = x.partidas;
    return partidas;
  }

  @override
  bool registradoJugador(Jugador j) {
    // TODO: implement registradoJugador
    throw UnimplementedError();
  }

  @override
  bool registrarJugador(Jugador j) {
    // TODO: implement registrarJugador
    throw UnimplementedError();
  }

  @override
  void registrarPartida(Partida p, Jugador j) {
    // TODO: implement registrarPartida
  }

}