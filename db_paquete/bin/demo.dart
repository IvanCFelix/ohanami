import 'db_paquete_memoria.dart';
import 'jugador.dart';
import 'partida.dart';

void main(List<String> args) {
  RepositorioMemoria r = RepositorioMemoria();
  Jugador juan = Jugador('Juan');
  print('Existe juan?');
  print(r.registradoJugador(juan));

  r.registrarJugador(juan);
  print(r.registradoJugador(juan));

  Partida p = Partida([juan],3,4);
  r.registrarPartida(p, juan);
  r.registrarPartida(p, juan);

  List<Partida> l = r.recuperarPartidas(juan);
  print(l);
}