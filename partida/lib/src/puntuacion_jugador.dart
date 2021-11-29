import 'package:partida/partida.dart';

class PuntuacionJugador {
  
  final Jugador jugador;
  final int porAzules;
  final int porVerdes;
  final int porRosas;
  final int porNegras;
  int get total => porAzules+porVerdes+porRosas+porNegras;
  
  PuntuacionJugador({
    required this.jugador,
    required this.porAzules,
    required this.porVerdes,
    required this.porRosas,
    required this.porNegras,
  }); 
}
