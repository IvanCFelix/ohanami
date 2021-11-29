import 'package:partida/partida.dart';
import 'package:partida/src/jugador.dart';

const int ninguna = 0;
const int maximoCartasPR1 = 10; 

class PRonda1{
  final Jugador jugador;
  final int cuantasAzules;

  PRonda1({ required this.jugador, required this.cuantasAzules}){
    if (cuantasAzules < ninguna ) throw ProblemaAzulesNegativas();
    if (cuantasAzules > maximoCartasPR1)throw ProblemaDemasiadasAzules();
  }
}

class PRonda2 {
  final Jugador jugador;
  final int cuantasAzules;
  final int cuantasVerdes;
  PRonda2({
    required this.jugador,
    required this.cuantasAzules,
    required this.cuantasVerdes,
  }){
    if (cuantasAzules < ninguna) throw ProblemaAzulesNegativas();
    if (cuantasVerdes < ninguna) throw ProblemaVerdesNegativas();
  } 
}

class PRonda3 {
  final Jugador jugador;
  final int cuantasAzules;
  final int cuantasVerdes;
  final int cuantasNegras;
  final int cuantasRosas;
  PRonda3({
    required this.jugador,
    required this.cuantasAzules,
    required this.cuantasVerdes,
    required this.cuantasNegras,
    required this.cuantasRosas,
  }){
    if (cuantasAzules < ninguna) throw ProblemaAzulesNegativas();
    if (cuantasVerdes < ninguna) throw ProblemaVerdesNegativas();
    if (cuantasNegras < ninguna) throw ProblemaNegrasNegativas();
    if (cuantasRosas < ninguna) throw ProblemaRosasNegativas();
  }
}

