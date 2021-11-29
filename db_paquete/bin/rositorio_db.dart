import 'jugador.dart';
import 'partida.dart';

abstract class RepositorioIdeal{
  bool registradoJugador(Jugador j);
  bool registrarJugador(Jugador j);
  void registrarPartida(Partida p, Jugador j);
  List<Partida> recuperarPartidas(Jugador j);

}