/*
import 'repositorio_db.dart';
import 'package:partida/partida.dart';

import 'usuario.dart';
class RepositorioMemoria extends RepositorioIdeal{
  final List<String> _listaJugadores = [];
  final Map<String,List<Partida>> _listaPartidas = {};
  RepositorioMemoria();

  @override
  Future<bool> registrarJugador(Jugador j) async {
    _listaJugadores.add(j.nombre);
    return true;
  }

  @override
  Future<bool> registradoJugador(Jugador j) async {
    return(_listaJugadores.contains(j.nombre));
  }


  @override
  void registrarPartida({required Partida p, required Usuario u}) {
    List<Partida> lista = _listaPartidas[u.nombre]?? [];
    lista.add(p);
    _listaPartidas[u.nombre] = lista;

  }

  @override
  Future<List<Partida>> recuperarPartidas({required Usuario u}) {
    // TODO: implement recuperarPartidas
    throw UnimplementedError();
  }

  @override
  Future<bool> registradoUsuario({required Usuario u}) {
    // TODO: implement registradoUsuario
    throw UnimplementedError();
  }

  @override
  Future<bool> registrarUsuario({required Usuario u}) {
    // TODO: implement registrarUsuario
    throw UnimplementedError();
  }







  
}
*/