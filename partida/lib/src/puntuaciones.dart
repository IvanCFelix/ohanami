import 'dart:convert';

import 'package:partida/partida.dart';
import 'package:partida/src/jugador.dart';

const int ninguna = 0;
const int maximoCartasPR1 = 10; 

class PRonda1 {
  final Jugador jugador;
  final int cuantasAzules;

  PRonda1({ required this.jugador, required this.cuantasAzules}){
    if (cuantasAzules < ninguna ) throw ProblemaAzulesNegativas();
    if (cuantasAzules > maximoCartasPR1)throw ProblemaDemasiadasAzules();
  }

  Map<String, dynamic> toMap() {
    return {
      'jugador': jugador.toMap(),
      'cuantasAzules': cuantasAzules,
    };
  }

  factory PRonda1.fromMap(Map<String, dynamic> map) {
    return PRonda1(
      jugador: Jugador.fromMap(map['jugador']),
      cuantasAzules: map['cuantasAzules'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PRonda1.fromJson(String source) => PRonda1.fromMap(json.decode(source));
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

  Map<String, dynamic> toMap() {
    return {
      'jugador': jugador.toMap(),
      'cuantasAzules': cuantasAzules,
      'cuantasVerdes': cuantasVerdes,
    };
  }

  factory PRonda2.fromMap(Map<String, dynamic> map) {
    return PRonda2(
      jugador: Jugador.fromMap(map['jugador']),
      cuantasAzules: map['cuantasAzules'],
      cuantasVerdes: map['cuantasVerdes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PRonda2.fromJson(String source) => PRonda2.fromMap(json.decode(source));
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

  Map<String, dynamic> toMap() {
    return {
      'jugador': jugador.toMap(),
      'cuantasAzules': cuantasAzules,
      'cuantasVerdes': cuantasVerdes,
      'cuantasNegras': cuantasNegras,
      'cuantasRosas': cuantasRosas,
    };
  }

  factory PRonda3.fromMap(Map<String, dynamic> map) {
    return PRonda3(
      jugador: Jugador.fromMap(map['jugador']),
      cuantasAzules: map['cuantasAzules'],
      cuantasVerdes: map['cuantasVerdes'],
      cuantasNegras: map['cuantasNegras'],
      cuantasRosas: map['cuantasRosas'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PRonda3.fromJson(String source) => PRonda3.fromMap(json.decode(source));
}

