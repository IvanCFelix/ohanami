import 'package:test/test.dart';
import 'package:partida/partida.dart';
import 'package:partida/src/problemas.dart';

void main() {
  group('Jugador', () {
    test('debe de tener un numero no vacio', (){
      expect(
        ()=> Jugador(nombre:''),
        throwsA(TypeMatcher<ProblemaNombreJugadorVacio>()));
    });
    test('Mismo nombre, mismo id', (){
      Jugador j1 = Jugador(nombre: 'Paco');
      Jugador j2 = Jugador(nombre: 'Paco');
      expect(j1, equals(j2));
    });
    test('deferente nombre, diferente instancias', (){
      Jugador j1 = Jugador(nombre: 'Paco');
      Jugador j2 = Jugador(nombre: 'Juan');
      expect(j1, isNot(equals(j2)));
      
    });
   }
   );
}