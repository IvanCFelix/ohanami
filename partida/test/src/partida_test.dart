import 'package:test/test.dart';
import 'package:partida/partida.dart';
import 'package:partida/src/puntuacion_jugador.dart';
import 'package:partida/src/puntuaciones.dart';

void main() {
  group('Partidas', () {
    late Jugador j1, j2, j3, j4, j5;
    setUp((){
      j1 = Jugador(nombre: 'Juan');
      j2 = Jugador(nombre: 'Pedro');
      j3 = Jugador(nombre: 'Paco');
      j4 = Jugador(nombre: 'Pepe');
      j5 = Jugador(nombre: 'Maria');
    });
    test('debe de tener al menos dos jugadores', (){
      expect(()=>Partida(jugadores: {j1}), 
      throwsA(TypeMatcher<ProblemaNumeroJugadoresMenorMinimo>()));
    });
    test('debe de tener maximo 4 jugadores', (){
      expect(()=>Partida(
        
        jugadores: 
        {j1,j2,j3,j4,j5}
      ), throwsA(TypeMatcher<ProblemaNumeroJugadoresMayorMaximo>()));
    });
    test('Con dos jugadores esta bien', (){
      expect(()=> Partida(jugadores: {j1, j2}), returnsNormally);
    });
   });
  group('Puntuaciones ronda 1', () {
     late Jugador j1, j2, j3;
     late CRonda1 p1, p2, p3;
     setUp((){
       j1 = Jugador(nombre: 'Pancho');
       j2 = Jugador(nombre: 'Paco');
       j3 = Jugador(nombre: 'Pedro');
       p1 = CRonda1(jugador: j1, cuantasAzules: 3);
       p3 = CRonda1(jugador: j3, cuantasAzules: 5);
       p2 = CRonda1(jugador: j2, cuantasAzules: 6);
       
     });
     test('Jugadores diferentes no se debe', (){
       Partida p = Partida(jugadores: {j1, j2});
       expect( ()=> p.cartasRonda1([p1,p3]), throwsA(TypeMatcher<ProblemaJugadoresNoConcuerdan>())
       );
     });
     test('Jugadores deben concordar', () {
       Partida p = Partida(jugadores: {j1, j2});
       expect( ()=> p.cartasRonda1([p1,p2]), returnsNormally);
     });
     
   });
  group('Puntuaciones Ronda 2', () {
    late Jugador j1, j2, j3;
    late CRonda1 p11, p12, p13;
    late CRonda2 p21, p22, p23;
    late CRonda1 p11mal, p12mal;
    setUp((){
      j1 = Jugador( nombre: 'Pancho');
      j2 = Jugador( nombre: 'Paco');
      j3 = Jugador( nombre: 'Pepe');

      p11 = CRonda1(jugador: j1, cuantasAzules: 0);
      p12 = CRonda1(jugador: j2, cuantasAzules: 0);
      p13 = CRonda1(jugador: j3, cuantasAzules: 7);
      
      p11mal = CRonda1(jugador: j1, cuantasAzules: 10);
      p12mal = CRonda1(jugador: j2, cuantasAzules: 10);

      p21 = CRonda2(jugador: j1, cuantasAzules: 1, cuantasVerdes: 1);
      p22 = CRonda2(jugador: j2, cuantasAzules: 2, cuantasVerdes: 2);
      p23 = CRonda2(jugador: j3, cuantasAzules: 1, cuantasVerdes: 1);
    });
    test('Jugadores diferentes manda error', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.cartasRonda1([p11, p12]);
      expect(() => p.cartasRonda2([p21, p23]), 
      throwsA(TypeMatcher<ProblemaJugadoresNoConcuerdan>()));
    });
    test('Jugadores si concuerdan', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.cartasRonda1([p11, p12]);
      expect( ()=> p.cartasRonda2([p21,p22]), 
      returnsNormally
      );
    });
    test('Debe ser llamado despues de puntuacion ronda 1', () {
      Partida p = Partida(jugadores: {j1, j2});
      expect(()=> p.cartasRonda2([p21, p22]),
      throwsA(TypeMatcher<ProblemaOrdenIncorrecto>())
      );
    });
    test('Cartas azules no deben de ser menores a el numero anterior', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.cartasRonda1([p11mal,p12mal]);
      expect( ()=> p.cartasRonda2([p21,p22]) , throwsA(TypeMatcher<ProblemaDisminucionAzules>()));
    });
    test('Cartas azules pueden ser iguales o mayores al numero anterior', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.cartasRonda1([p11,p12]);
      expect( ()=> p.cartasRonda2([p21,p22]) , returnsNormally);
    }); 
    test('Cartas azules deben ser iguales o mayores', () {
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11, p12]);
      expect(()=> p.cartasRonda2([p21, p22]), returnsNormally);
    });

    test('Maximo de cartas verdes es 20', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11, p12]);
      expect(()=> p.cartasRonda2([CRonda2(jugador: j1, cuantasAzules: 1, cuantasVerdes: 30),
      CRonda2(jugador: j2, cuantasAzules: 0, cuantasVerdes: 0)]),
      throwsA(TypeMatcher<ProblemaDemasiadasVerdes>()) );
    });

    test('Maximo de cartas azules es 20', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.cartasRonda1([p11, p12]);
      expect(() => p.cartasRonda2(
        [
          CRonda2(jugador: j1, cuantasAzules: 21, cuantasVerdes: 0),
          CRonda2(jugador: j2, cuantasAzules: 3, cuantasVerdes: 0)
        ]
      ),
      throwsA(TypeMatcher<ProblemaDemasiadasAzules>()));
    });  
    test('Maximo de cartas es 20', () {
      Partida p = Partida(jugadores: {j1, j2});
      p.cartasRonda1([p11, p12]);
      expect(() => p.cartasRonda2(
        [
          CRonda2(jugador: j1, cuantasAzules: 11, cuantasVerdes: 11),
          CRonda2(jugador: j2, cuantasAzules: 0, cuantasVerdes: 0)
        ]
      ),
      throwsA(TypeMatcher<ProblemaExcesoCartas>()));
    });
  });
  group('Puntuaciones Ronda 3', () {
    late Jugador j1, j2, j3;
    late CRonda1 p11, p12, p13;
    late CRonda2 p21, p22, p23;
    late CRonda3 p31, p32, p33;
    late CRonda3 p31mal, p32mal;

    setUp((){
      j1 = Jugador( nombre: 'Pancho');
      j2 = Jugador( nombre: 'Paco');
      j3 = Jugador( nombre: 'Pepe');

      p11 = CRonda1(jugador: j1, cuantasAzules: 0);
      p12 = CRonda1(jugador: j2, cuantasAzules: 0);
      p13 = CRonda1(jugador: j3, cuantasAzules: 7);

      p21 = CRonda2(jugador: j1, cuantasAzules: 1, cuantasVerdes: 1);
      p22 = CRonda2(jugador: j2, cuantasAzules: 2, cuantasVerdes: 2);
      p23 = CRonda2(jugador: j3, cuantasAzules: 1, cuantasVerdes: 1);

      p31 = CRonda3(jugador: j1, cuantasAzules: 2, cuantasVerdes: 2, cuantasRosas: 2, cuantasNegras: 2);
      p32 = CRonda3(jugador: j2, cuantasAzules: 3, cuantasVerdes: 3, cuantasRosas: 3, cuantasNegras: 3);
      p33 = CRonda3(jugador: j3, cuantasAzules: 2, cuantasVerdes: 2, cuantasRosas: 2, cuantasNegras: 2);
      
    });

    test('Llamado sin ejecutar ronda 2', (){
      Partida p = Partida(jugadores: {j1,j2});
      expect(()=> p.cartasRonda3([p31,p32]),
      throwsA(TypeMatcher<ProblemaOrdenIncorrecto>()));
    });
    test('Llamado despues de la ronda 2 ', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      expect(()=> p.cartasRonda3([p31,p32]),returnsNormally);
    });
    test('Jugadores no concuerdan', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      expect(()=>p.cartasRonda3([p31,p33]), 
      throwsA(TypeMatcher<ProblemaJugadoresNoConcuerdan>()));
    });
    test('Jugadores concuerdan', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      expect(()=>p.cartasRonda3([p31,p32]), returnsNormally);
    });
    test('Azules no deben ser menores a la ronda anterior', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p31mal = CRonda3(jugador: j1, cuantasAzules: 0, cuantasVerdes: 3, cuantasNegras: 3, cuantasRosas: 3);
      expect(()=> p.cartasRonda3([p31mal,p32]),
      throwsA(TypeMatcher<ProblemaDisminucionAzules>()));
    });
    test('Azules iguales o mayores a la ronda anterior', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      expect(()=> p.cartasRonda3([p31,p32]),returnsNormally);
    });
    test('Verdes no deben ser menores a la ronda anterior', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p32mal = CRonda3(jugador: j2, cuantasAzules: 4, cuantasVerdes: 0, cuantasNegras: 4, cuantasRosas: 4);
      expect(()=> p.cartasRonda3([p31,p32mal]),
      throwsA(TypeMatcher<ProblemaDisminucionVerdes>()));
    });
    test('Verdes iguales o mayores a la ronda anterior', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      expect(()=> p.cartasRonda3([p31,p32]),returnsNormally);
    });
    test('Azules en total no debe pasar de 30', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p31 = CRonda3(jugador: j1, cuantasAzules: 31, cuantasVerdes: 2, cuantasRosas: 2, cuantasNegras: 2);
      expect(()=> p.cartasRonda3([p31,p32]),
      throwsA(TypeMatcher<ProblemaDemasiadasAzules>()));
    });
    test('Verdes en total no debe pasar de 30', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p31 = CRonda3(jugador: j1, cuantasAzules: 3, cuantasVerdes: 31, cuantasRosas: 2, cuantasNegras: 2);
      expect(()=> p.cartasRonda3([p31,p32]),
      throwsA(TypeMatcher<ProblemaDemasiadasVerdes>()));
    });
    test('Rosas en total no debe pasar de 30', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p31 = CRonda3(jugador: j1, cuantasAzules: 3, cuantasVerdes: 3, cuantasRosas: 31, cuantasNegras: 2);
      expect(()=> p.cartasRonda3([p31,p32]),
      throwsA(TypeMatcher<ProblemaDemasiadasRosas>()));
    });
    test('Negras en total no debe pasar de 30', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p31 = CRonda3(jugador: j1, cuantasAzules: 3, cuantasVerdes: 4, cuantasRosas: 2, cuantasNegras: 31);
      expect(()=> p.cartasRonda3([p31,p32]),
      throwsA(TypeMatcher<ProblemaDemasiadasNegras>()));
    });
    test('En total no debe pasar de 30', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p31 = CRonda3(jugador: j1, cuantasAzules: 29, cuantasVerdes: 29, cuantasRosas: 29, cuantasNegras: 29);
      expect(()=> p.cartasRonda3([p31,p32]),
      throwsA(TypeMatcher<ProblemaExcesoCartas>()));
    });

  });
  group('Puntos', () {

    late Jugador j1, j2, j3;
    late CRonda1 p11, p12, p13;
    late CRonda2 p21, p22, p23;
    late CRonda3 p31, p32, p33;
    late CRonda3 p31mal, p32mal;
    late var ronda1, ronda2, ronda3, rondafinal;

    setUp((){
      j1 = Jugador( nombre: 'Pancho');
      j2 = Jugador( nombre: 'Paco');
      j3 = Jugador( nombre: 'Pepe');

      p11 = CRonda1(jugador: j1, cuantasAzules: 1);
      p12 = CRonda1(jugador: j2, cuantasAzules: 0);
      p13 = CRonda1(jugador: j3, cuantasAzules: 0);

      p21 = CRonda2(jugador: j1, cuantasAzules: 1, cuantasVerdes: 1);
      p22 = CRonda2(jugador: j2, cuantasAzules: 2, cuantasVerdes: 2);
      p23 = CRonda2(jugador: j3, cuantasAzules: 1, cuantasVerdes: 1);

      p31 = CRonda3(jugador: j1, cuantasAzules: 2, cuantasVerdes: 2, cuantasRosas: 2, cuantasNegras: 2);
      p32 = CRonda3(jugador: j2, cuantasAzules: 3, cuantasVerdes: 3, cuantasRosas: 3, cuantasNegras: 3);
      p33 = CRonda3(jugador: j3, cuantasAzules: 2, cuantasVerdes: 2, cuantasRosas: 2, cuantasNegras: 2);
      
      ronda1 = FasePuntuacion.Ronda1;
      ronda2 = FasePuntuacion.Ronda2;
      ronda3 = FasePuntuacion.Ronda3;
      rondafinal = FasePuntuacion.desenlace;
      
    });
    
    test('Probar puntuaciones ronda 1', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda1([]);
      expect(p.puntos(ronda: ronda1) , isA<List<PuntuacionJugador>>() );
    });
    test('Probar puntuaciones ronda 2', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      expect(p.puntos(ronda: ronda2) , isA<List<PuntuacionJugador>>());
    });
    test('Probar puntuaciones ronda 3', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p.cartasRonda3([p31,p32]);
      expect(p.puntos(ronda: ronda3) , isA<List<PuntuacionJugador>>());
    });
    test('Probar puntuaciones ronda final', (){
      Partida p = Partida(jugadores: {j1,j2});
      p.cartasRonda1([p11,p12]);
      p.cartasRonda2([p21,p22]);
      p.cartasRonda3([p31,]);

      p.puntos(ronda: ronda3);

      expect(p.puntos(ronda: rondafinal) , isA<List<PuntuacionJugador>>());
    });  
   });

}