import 'db_paquete_memoria.dart';
import 'package:partida/partida.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'repositorio_mongo.dart';
import 'usuario.dart';

void main(List<String> args) async{
  RepositorioMemoria r = RepositorioMemoria();
  RepsitorioMongo db = RepsitorioMongo();
  Jugador juan = Jugador(nombre: 'Juan');
  Jugador maria = Jugador(nombre: 'Maria');
  Jugador jose =  Jugador(nombre: 'Jose');
  Jugador pepe =  Jugador(nombre: 'Pepe');
  Jugador paul =  Jugador(nombre: 'Paul');
  Partida partida1 = Partida(jugadores: {paul,jose,pepe});
  Partida partida2 = Partida(jugadores: {paul,pepe});
  Usuario usuario = Usuario(nombre: 'Martin', telefono: 1234567891, partidas:[partida1, partida2]);
  print('Empezando');
  //print('Existe juan?');
  //print(r.registradoJugador(juan));

  //r.registrarJugador(juan);
  //print(r.registradoJugador(juan));

  //Partida p = Partida(jugadores:{juan,maria});
  //r.registrarPartida(p, juan);
  //r.registrarPartida(p, juan);

  
  db.recuperarPartidas(u: usuario );
  //print("Terminado");
  //List<Partida> l = r.recuperarPartidas(juan);
  //print(l);
  /*
  db.inicializar();
  await db..open();
  
  
  await col.insert(jsonDecode(usuario.toJson()));
  
  var val = await col.findOne(where.eq('nombre', 'Martin'));
  var res = val!.remove('_id');
  Usuario x = Usuario.fromMap(val);
  print(x);

  
  //print("Terminado");
  await db.close();*/
}