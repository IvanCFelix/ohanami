import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'jugador': jugador.toMap(),
      'porAzules': porAzules,
      'porVerdes': porVerdes,
      'porRosas': porRosas,
      'porNegras': porNegras,
    };
  }

  factory PuntuacionJugador.fromMap(Map<String, dynamic> map) {
    return PuntuacionJugador(
      jugador: Jugador.fromMap(map['jugador']),
      porAzules: map['porAzules'],
      porVerdes: map['porVerdes'],
      porRosas: map['porRosas'],
      porNegras: map['porNegras'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PuntuacionJugador.fromJson(String source) => PuntuacionJugador.fromMap(json.decode(source));
}
