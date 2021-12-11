import 'dart:convert';

import 'package:partida/partida.dart';
import 'package:partida/src/jugador.dart';

const int ninguna = 0;
const int maximoCartasPR1 = 10; 

class CRonda1 {
  final Jugador jugador;
  final int cuantasAzules;

  CRonda1({ required this.jugador, required this.cuantasAzules}){
    if (cuantasAzules < ninguna ) throw ProblemaAzulesNegativas();
    if (cuantasAzules > maximoCartasPR1)throw ProblemaDemasiadasAzules();
  }

  Map<String, dynamic> toMap() {
    return {
      'jugador': jugador.toMap(),
      'cuantasAzules': cuantasAzules,
    };
  }

  factory CRonda1.fromMap(Map<String, dynamic> map) {
    return CRonda1(
      jugador: Jugador.fromMap(map['jugador']),
      cuantasAzules: map['cuantasAzules'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CRonda1.fromJson(String source) => CRonda1.fromMap(json.decode(source));
}

class CRonda2 {
  final Jugador jugador;
  final int cuantasAzules;
  final int cuantasVerdes;
  CRonda2({
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

  factory CRonda2.fromMap(Map<String, dynamic> map) {
    return CRonda2(
      jugador: Jugador.fromMap(map['jugador']),
      cuantasAzules: map['cuantasAzules'],
      cuantasVerdes: map['cuantasVerdes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CRonda2.fromJson(String source) => CRonda2.fromMap(json.decode(source));
}

class CRonda3 {
  final Jugador jugador;
  final int cuantasAzules;
  final int cuantasVerdes;
  final int cuantasNegras;
  final int cuantasRosas;
  CRonda3({
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

  factory CRonda3.fromMap(Map<String, dynamic> map) {
    return CRonda3(
      jugador: Jugador.fromMap(map['jugador']),
      cuantasAzules: map['cuantasAzules'],
      cuantasVerdes: map['cuantasVerdes'],
      cuantasNegras: map['cuantasNegras'],
      cuantasRosas: map['cuantasRosas'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CRonda3.fromJson(String source) => CRonda3.fromMap(json.decode(source));
}

