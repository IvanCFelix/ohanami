import 'package:mongo_dart/mongo_dart.dart';

import 'package:partida/partida.dart';
import 'repositorio_db.dart';
import 'usuario.dart';



class RepsitorioMongo extends RepositorioIdeal{
  late Db db;
  late var colexion;
  RepsitorioMongo(){}
  
  void inicializar() async{
    db = await Db.create('mongodb+srv://root:root@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
    await db..open();
    var colexion = db.collection('usuarios');
  }

  @override
  Future<List<Partida>> recuperarPartidas({ required Usuario u}) async {
    var val = await colexion.findOne(where.eq('nombre', u.nombre));
    var res = val!.remove('_id');
    val = res.remove('nombre');
    res = val.remove('telefono');
    Usuario x = Usuario.fromMap(res);
    print(x);
    throw UnimplementedError();
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