
import 'package:mongo_dart/mongo_dart.dart';

import 'partida.dart';
import 'jugador.dart';
import 'rositorio_db.dart';

class RepsitorioMongo extends RepositorioIdeal{
  late Db _datos;
  RepsitorioMongo(){}
  
  void inicializar() async{
    _datos = await Db.create('mongodb+srv://a1000kr:<hansel>@cluster0.bigji.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
  
  }

  @override
  List<Partida> recuperarPartidas(Jugador j) {
    // TODO: implement recuperarPartidas
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