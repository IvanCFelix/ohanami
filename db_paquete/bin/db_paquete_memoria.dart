import 'jugador.dart';
import 'partida.dart';
import 'rositorio_db.dart';

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
  List<Partida> recuperarPartidas(Jugador j) {
    List<Partida> lista = _listaPartidas[j.nombre] ?? [];
    return lista;
  }
  
}