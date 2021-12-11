import 'package:db_paquete/db_paquete.dart';
import 'package:partida/partida.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

void main(List<String> args) async{
  //RepositorioMemoria r = RepositorioMemoria();
  RepositorioMongo db = RepositorioMongo();
  late Jugador j1, j2, j3;
  late PRonda1 p11, p12, p13;
  late PRonda2 p21, p22, p23;
  late PRonda3 p31, p32, p33;
  late PRonda3 p31mal, p32mal;

  j1 = Jugador( nombre: 'Pancho');
  j2 = Jugador( nombre: 'Paco');
  j3 = Jugador( nombre: 'Pepe');

  p11 = PRonda1(jugador: j1, cuantasAzules: 1);
  p12 = PRonda1(jugador: j2, cuantasAzules: 0);
  p13 = PRonda1(jugador: j3, cuantasAzules: 0);

  p21 = PRonda2(jugador: j1, cuantasAzules: 1, cuantasVerdes: 1);
  p22 = PRonda2(jugador: j2, cuantasAzules: 2, cuantasVerdes: 2);
  p23 = PRonda2(jugador: j3, cuantasAzules: 1, cuantasVerdes: 1);

  p31 = PRonda3(jugador: j1, cuantasAzules: 2, cuantasVerdes: 2, cuantasRosas: 2, cuantasNegras: 2);
  p32 = PRonda3(jugador: j2, cuantasAzules: 3, cuantasVerdes: 3, cuantasRosas: 3, cuantasNegras: 3);
  p33 = PRonda3(jugador: j3, cuantasAzules: 2, cuantasVerdes: 2, cuantasRosas: 2, cuantasNegras: 2);

  Partida p = Partida(jugadores: {j1,j2});
  p.cartasRonda1([p11,p12]);
  p.cartasRonda2([p21,p22]);
  p.cartasRonda3([p31,p32]);
  print('Empezando');
  Usuario hansel = Usuario(nombre: 'Hansel', telefono: 1456781249, clave: "ewgui", partidas: [p]);
  await db.registrarUsuario(usuario:hansel);
  List<Partida> partidas =  await db.recuperarPartidas(usuario: hansel);
  print(partidas);
  print("Termino");
  
}