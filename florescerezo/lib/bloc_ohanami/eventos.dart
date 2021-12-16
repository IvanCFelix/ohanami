
import 'package:flutter/material.dart';
import 'package:partida/partida.dart';

class Evento {}

class SiguienteRonda2 extends Evento{
 final Partida partida;
 final List<IconData> iconosJugadores;

  SiguienteRonda2({required this.partida, required this.iconosJugadores});
}

class SiguienteRonda3 extends Evento{
   final Partida partida;
   final List<IconData> iconosJugadores;

  SiguienteRonda3({required this.partida, required this.iconosJugadores});
}

class SiguienteRonda1 extends Evento{
   final Partida partida;
   final List<IconData> iconosJugadores;
   
  SiguienteRonda1({required this.partida, required this.iconosJugadores});
}
