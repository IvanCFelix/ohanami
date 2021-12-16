import 'dart:convert';

import 'package:partida/src/problemas.dart';

class Jugador {
  final String nombre;
  

  Jugador({
    required this.nombre,
  }) {
    if (nombre.isEmpty) throw ProblemaNombreJugadorVacio();
  }
  int get id => nombre.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Jugador &&
      other.nombre == nombre;
  }

  @override
  int get hashCode => nombre.hashCode;

  Jugador copyWith({
    String? nombre,
  }) {
    return Jugador(
      nombre: nombre ?? this.nombre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
    };
  }

  factory Jugador.fromMap(Map<String, dynamic> map) {
    return Jugador(
      nombre: map['nombre'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Jugador.fromJson(String source) => Jugador.fromMap(json.decode(source));

  @override
  String toString() => 'Jugador(nombre: $nombre)';
}
