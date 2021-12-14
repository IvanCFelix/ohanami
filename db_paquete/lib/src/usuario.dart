import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:partida/partida.dart';

class Usuario {
   String nombre;
   String correo;
   String clave;
  final List<Partida> partidas;
  Usuario({
    required this.nombre,
    required this.correo,
    required this.clave,
    required this.partidas,
  });


  Usuario copyWith({
    String? nombre,
    String? correo,
    String? clave,
    List<Partida>? partidas,
  }) {
    return Usuario(
      nombre: nombre ?? this.nombre,
      correo: correo ?? this.correo,
      clave: clave ?? this.clave,
      partidas: partidas ?? this.partidas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'correo': correo,
      'clave': clave,
      'partidas': partidas.map((x) => x.toMap()).toList(),
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nombre: map['nombre'],
      correo: map['correo'],
      clave: map['clave'],
      partidas: List<Partida>.from(map['partidas']?.map((x) => Partida.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(nombre: $nombre, correo: $correo, clave: $clave, partidas: $partidas)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is Usuario &&
      other.nombre == nombre &&
      other.correo == correo &&
      other.clave == clave &&
      listEquals(other.partidas, partidas);
  }

  @override
  int get hashCode {
    return nombre.hashCode ^
      correo.hashCode ^
      clave.hashCode ^
      partidas.hashCode;
  }
}
