import 'package:partida/partida.dart';
import 'usuario.dart';

abstract class RepositorioIdeal{
  bool registradoJugador(Jugador j);
  bool registrarJugador(Jugador j);
  void registrarPartida(Partida p, Jugador j);
  Future<List<Partida>> recuperarPartidas({required Usuario u});

}