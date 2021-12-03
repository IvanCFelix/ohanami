import 'package:db_paquete/db_paquete.dart';
import 'package:partida/partida.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

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
  Partida partida4 = Partida(jugadores: {paul,maria,pepe});
  Partida partida5 = Partida(jugadores: {paul,juan});
  Partida partida6 = Partida(jugadores: {maria,juan});
  Partida partida7 = Partida(jugadores: {maria,juan});
  Partida partida8 = Partida(jugadores: {maria,juan});
  Partida partida9 = Partida(jugadores: {maria,juan});
  Partida partida10 = Partida(jugadores: {maria,juan});
  /*
  Usuario martin = Usuario(clave:'asdsa',nombre:'Martin', telefono: 1785624371, partidas:[]);
  Usuario pepeU = Usuario(clave:'ef7fe',nombre: 'Pepe', telefono: 1232467231, partidas:[]);
  Usuario hansel = Usuario(clave:'helk',nombre: 'Hansel', telefono: 1232231468, partidas:[]);
  Usuario armando = Usuario(clave:'12345',nombre: 'Armando', telefono: 1246957230, partidas:[partida1, partida2, partida3]);
  */
  Usuario claudia = Usuario(clave:'yebnm',nombre:'Claudia', telefono: 1785624371, partidas:[]);
  bool check;
  print('Empezando');
  await db.registrarUsuario(usuario: claudia);
  check =  await db.registrarPartida(partida: partida7, usuario: claudia);
  check ? print("true") : print("false");
  check =  await db.registrarPartida(partida: partida8, usuario: claudia);
  check ? print("true") : print("false");
  check =  await db.registrarPartida(partida: partida9, usuario: claudia);
  check ? print("true") : print("false");
  check =  await db.registrarPartida(partida: partida1, usuario: claudia);
  check ? print("true") : print("false");
  print("Termino");
}