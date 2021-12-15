class ProblemaNombreJugadorVacio implements Exception {
@override
String toString() => 'Todos los jugadores deben tener un nombre';
}

class ProblemaNumeroJugadoresMenorMinimo implements Exception {
@override
String toString() => 'Se necesitan mÃ¡s jugadores para iniciar una partida';
}

class ProblemaNumeroJugadoresMayorMaximo implements Exception {
@override
String toString() => 'Hay demasiados jugadores en esta partida';
}

class ProblemaJugadoresRepetidos implements Exception {
@override
String toString() => 'Los jugadores no se deben repetir';
}

class ProblemaAzulesNegativas implements Exception {
@override
String toString() => 'El numero de cartas azules no pueden ser negativas';
}

class ProblemaDemasiadasAzules implements Exception {
@override
  String toString() => 'La cantidad de cartas azules jugadas sobrepasa el limite permitido para esta ronda ';
}

class ProblemaJugadoresNoConcuerdan implements Exception {
@override
String toString() => 'Los jugadores a puntuar no concuerdan';
}

class ProblemaVerdesNegativas implements Exception {
@override
String toString() => 'El numero de cartas verdes no pueden ser negativas';
}
class ProblemaOrdenIncorrecto implements Exception {
@override
String toString() => 'Los jugadores a puntuar no concuerdan';
}

class ProblemaDisminucionAzules implements Exception {
@override
String toString() => 'El numero que esta ingresando para cartas azules no puede ser menor a la ronda anterior';
}

class ProblemaDemasiadasVerdes implements Exception {
@override
String toString() => 'La cantidad de cartas verdes jugadas sobrepasa el limite permitido para esta ronda ';
}

class ProblemaExcesoCartas implements Exception {
@override
String toString() => 'La suma de las cartas por jugador excede el limite permitido para esta ronda';
}

class ProblemaNegrasNegativas implements Exception {
@override
String toString() => 'El numero de cartas negras no pueden ser negativas';
}

class ProblemaRosasNegativas implements Exception {
@override
String toString() => 'El numero de cartas rosas no pueden ser negativas';
}

class ProblemaDisminucionVerdes implements Exception {
@override
String toString() => 'El numero que esta ingresando para cartas verdes no puede ser menor a la ronda anterior';
}

class ProblemaDemasiadasRosas implements Exception {
@override
  String toString() => 'La cantidad de cartas rosas jugadas sobrepasa el limite permitido para esta ronda ';
}

class ProblemaDemasiadasNegras implements Exception {
@override
  String toString() => 'La cantidad de cartas negras jugadas sobrepasa el limite permitido para esta ronda ';
}