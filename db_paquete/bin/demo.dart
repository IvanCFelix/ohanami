import 'db_paquete_memoria.dart';
import 'package:partida/partida.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'repositorio_mongo.dart';
import 'usuario.dart';

void main(List<String> args) async{
  //RepositorioMemoria r = RepositorioMemoria();
  RepsitorioMongo db = RepsitorioMongo();
  Jugador juan = Jugador(nombre: 'Juan');
  Jugador maria = Jugador(nombre: 'Maria');
  Jugador jose =  Jugador(nombre: 'Jose');
  Jugador pepe =  Jugador(nombre: 'Pepe');
  Jugador paul =  Jugador(nombre: 'Paul');
  Partida partida1 = Partida(jugadores: {paul,jose,pepe});
  Partida partida2 = Partida(jugadores: {paul,pepe});
  Partida partida3 = Partida(jugadores: {maria,pepe});
  Usuario martin = Usuario(clave:'asdsa',nombre:'Martin', telefono: 1234567891, partidas:[]);
  Usuario pepeU = Usuario(clave:'asdsa',nombre: 'Pepe', telefono: 1234567891, partidas:[partida1, partida2]);
  Usuario hansel = Usuario(clave:'asdsa',nombre: 'Hansel', telefono: 1234567891, partidas:[partida1]);
  Usuario armando = Usuario(clave:'12345',nombre: 'Armando', telefono: 1234567891, partidas:[]);
  print('Empezando');
  //await db.registrarUsuario(u:armando);
  await db.verificarInicioSesion(usuario: armando);
  print("Termino");
}