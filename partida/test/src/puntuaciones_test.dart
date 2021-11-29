import 'package:test/test.dart';
import 'package:partida/partida.dart';
import 'package:partida/src/puntuaciones.dart';

void main() {
  group('Puntuaciones Ronda 1', () {
    late Jugador jugador; 
    setUp((){
      jugador = Jugador(nombre: 'x');

    }); 
    test('La cantidad de azules debe ser cero o mayor', (){
      expect(()=> PRonda1(jugador: jugador, cuantasAzules: -1),
      throwsA(TypeMatcher<ProblemaAzulesNegativas>())
      );
    });
    test('Maximo azules es 10', () {
      expect(()=> PRonda1(jugador: jugador, cuantasAzules: 11),
      throwsA(TypeMatcher<ProblemaDemasiadasAzules>())
      );
    });
    test('Cantidad entre 1 y 10 esta bien', () {
      expect(()=> PRonda1(jugador: jugador, cuantasAzules: 3),
      returnsNormally
      );
    });
  });

  group('Puntuacion Ronda 2', () {
    late Jugador jugador;
    setUp((){
      jugador = Jugador(nombre: 'Poncho');
    });
    test('Cartas azules no deben ser negativas', () {
      expect(()=> PRonda2(jugador: jugador, cuantasAzules:  -1, cuantasVerdes:  0), 
      throwsA(TypeMatcher<ProblemaAzulesNegativas>()));
    });
    test('Se aceptan numeros positivos de cartas azules', () {
      PRonda1(jugador: jugador, cuantasAzules: 3);
      expect(()=> PRonda2(
        jugador: jugador, cuantasAzules: 3, cuantasVerdes: 3 ), 
        returnsNormally);
    });
    test('Cartas verdes deben ser positivas', () {
      PRonda1(jugador: jugador, cuantasAzules: 3);
      expect(()=> PRonda2(jugador: jugador, 
      cuantasAzules: 3, cuantasVerdes: 0), 
      returnsNormally
      );
    });
    test('Cartas verdes no deben ser negativas', () {
      expect(()=> PRonda2(jugador: jugador, cuantasAzules: 0, cuantasVerdes: -1),
      throwsA(TypeMatcher<ProblemaVerdesNegativas>())
      );
    });
  });

  group('Puntuacion Ronda 3', () {
    late Jugador jugador;
    setUp((){
      jugador = Jugador(nombre: 'Poncho');
    });
    test('Se aceptan numeros positivos de cartas azules', () {
      PRonda1(jugador: jugador, cuantasAzules: 3);
      expect(()=> PRonda3(
        jugador: jugador, cuantasAzules: 3, cuantasVerdes: 3,
        cuantasNegras: 0, cuantasRosas: 0 ), 
        returnsNormally);
    });
    test('Cartas azules no deben ser negativas', () {
      expect(()=> PRonda3(jugador: jugador, cuantasAzules:  -1, cuantasVerdes:  0, 
      cuantasNegras: 0, cuantasRosas: 0), 
      throwsA(TypeMatcher<ProblemaAzulesNegativas>()));
    });
    test('Cartas verdes deben ser positivas', () {
      PRonda1(jugador: jugador, cuantasAzules: 3);
      expect(()=> PRonda3(jugador: jugador, 
      cuantasAzules: 3, cuantasVerdes: 0, cuantasNegras: 0, cuantasRosas: 0), 
      returnsNormally
      );
    });
    test('Cartas verdes no deben ser negativas', () {
      expect(()=> PRonda3(jugador: jugador, cuantasAzules: 0, cuantasVerdes: -1,
      cuantasRosas: 0, cuantasNegras: 0),
      throwsA(TypeMatcher<ProblemaVerdesNegativas>())
      );
    });
    test('Cartas negras deben ser positivas', () {
      PRonda1(jugador: jugador, cuantasAzules: 3);
      expect(()=> PRonda3(jugador: jugador, 
      cuantasAzules: 0, cuantasVerdes: 0, cuantasNegras: 3, cuantasRosas: 0), 
      returnsNormally
      );
    });
    test('Cartas negras no deben ser negativas', () {
      expect(()=> PRonda3(jugador: jugador, cuantasAzules: 0, cuantasVerdes: 0,
      cuantasRosas: 0, cuantasNegras: -3),
      throwsA(TypeMatcher<ProblemaNegrasNegativas>())
      );
    });
    test('Cartas rosas deben ser positivas', () {
      PRonda1(jugador: jugador, cuantasAzules: 3);
      expect(()=> PRonda3(jugador: jugador, 
      cuantasAzules: 0, cuantasVerdes: 0, cuantasNegras: 0, cuantasRosas: 5), 
      returnsNormally
      );
    });
    test('Cartas rosas no deben ser negativas', () {
      expect(()=> PRonda3(jugador: jugador, cuantasAzules: 0, cuantasVerdes: 0,
      cuantasRosas: -4, cuantasNegras: 0),
      throwsA(TypeMatcher<ProblemaRosasNegativas>())
      );
    });
  });
}


