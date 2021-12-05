import 'package:db_paquete/db_paquete.dart';
import 'package:partida/partida.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

void main(List<String> args) async{
  //RepositorioMemoria r = RepositorioMemoria();
  //RepsitorioMongo db = RepsitorioMongo();

  Jugador jose =  Jugador(nombre: 'Jose');
  Jugador pepe =  Jugador(nombre: 'Pepe');
  Jugador paul =  Jugador(nombre: 'Paul');
  Partida partida1 = Partida(jugadores: {paul,jose,pepe});
  Partida partida2 = Partida(jugadores: {paul,pepe});
  Usuario claudia = Usuario(clave:'yebnm',nombre:'Claudia', telefono: 1785624371, partidas:[partida1, partida2]);

  print('Empezando');
  String x = jsonEncode(claudia);

  var i = jsonDecode(x);
  Usuario mariano = Usuario.fromJson(i);

  print("Termino");
}