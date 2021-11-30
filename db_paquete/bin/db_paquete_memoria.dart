import 'repositorio_db.dart';
import 'package:partida/partida.dart';

import 'usuario.dart';
class RepositorioMemoria extends RepositorioIdeal{
  final List<String> _listaJugadores = [];
  final Map<String,List<Partida>> _listaPartidas = {};
  RepositorioMemoria();

  @override
  bool registrarJugador(Jugador j) {
    _listaJugadores.add(j.nombre);
    return true;
  }

  @override
  bool registradoJugador(Jugador j) {
    return(_listaJugadores.contains(j.nombre));
  }


  @override
  void registrarPartida(Partida p, Jugador j) {
    List<Partida> lista = _listaPartidas[j.nombre]?? [];
    lista.add(p);
    _listaPartidas[j.nombre] = lista;

  }

  @override
  Future<List<Partida>> recuperarPartidas({required Usuario u}) {
    // TODO: implement recuperarPartidas
    throw UnimplementedError();
  }

  @override
  Future<List<Partida>> recuperarMisPartidas({required Usuario u}) {
    // TODO: implement recuperarMisPartidas
    throw UnimplementedError();
  }







  
}