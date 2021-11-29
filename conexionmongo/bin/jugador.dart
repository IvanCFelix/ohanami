import 'dart:convert';

class Jugador {
  final String nombre;
  final int cuantasVerdes;

  Jugador({
    required this.nombre,
    required this.cuantasVerdes,
  });
    

  Jugador copyWith({
    String? nombre,
    int? cuantasVerdes,
  }) {
    return Jugador(
      nombre: nombre ?? this.nombre,
      cuantasVerdes: cuantasVerdes ?? this.cuantasVerdes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'cuantasVerdes': cuantasVerdes,
    };
  }

  factory Jugador.fromMap(Map<String, dynamic> map) {
    return Jugador(
      nombre: map['nombre'],
      cuantasVerdes: map['cuantasVerdes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Jugador.fromJson(String source) => Jugador.fromMap(json.decode(source));

  @override
  String toString() => 'Jugador(nombre: $nombre, cuantasVerdes: $cuantasVerdes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Jugador &&
      other.nombre == nombre &&
      other.cuantasVerdes == cuantasVerdes;
  }

  @override
  int get hashCode => nombre.hashCode ^ cuantasVerdes.hashCode;
}
