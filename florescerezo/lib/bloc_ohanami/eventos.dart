
import 'package:partida/partida.dart';

class Evento {}

class SiguienteRonda2 extends Evento{
 final Partida partida;

  SiguienteRonda2({required this.partida});
}

class SiguienteRonda3 extends Evento{
   final Partida partida;

  SiguienteRonda3({required this.partida});
}

class SiguienteRonda1 extends Evento{
   final Partida partida;

  SiguienteRonda1({required this.partida});
}
