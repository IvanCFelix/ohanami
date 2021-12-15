class ProblemaNombreJugadorVacio extends Error implements Exception {
@override
String toString() => 'Todos los jugadores deben tener un nombre';
}

class ProblemaNumeroJugadoresMenorMinimo extends Error implements Exception {
@override
String toString() => 'Se necesitan mÃ¡s jugadores para iniciar una partida';
}

class ProblemaNumeroJugadoresMayorMaximo extends Error implements Exception {
@override
String toString() => 'Hay demasiados jugadores en esta partida';
}

class ProblemaJugadoresRepetidos extends Error implements Exception {
@override
String toString() => 'Los jugadores no se deben repetir';
}

class ProblemaAzulesNegativas extends Error implements Exception {
@override
String toString() => 'El numero de cartas azules no pueden ser negativas';
}

class ProblemaDemasiadasAzules extends Error implements Exception {
@override
  String toString() => 'La cantidad de cartas azules jugadas sobrepasa el limite permitido para esta ronda ';
}

class ProblemaJugadoresNoConcuerdan extends Error implements Exception {
@override
String toString() => 'Los jugadores a puntuar no concuerdan';
}

class ProblemaVerdesNegativas extends Error implements Exception {
@override
String toString() => 'El numero de cartas verdes no pueden ser negativas';
}
class ProblemaOrdenIncorrecto extends Error implements Exception {
@override
String toString() => 'Los jugadores a puntuar no concuerdan';
}

class ProblemaDisminucionAzules extends Error implements Exception {
@override
String toString() => 'El numero que esta ingresando para cartas azules no puede ser menor a la ronda anterior';
}

class ProblemaDemasiadasVerdes extends Error implements Exception {
@override
String toString() => 'La cantidad de cartas verdes jugadas sobrepasa el limite permitido para esta ronda ';
}

class ProblemaExcesoCartas extends Error implements Exception {
@override
String toString() => 'La suma de las cartas por jugador excede el limite permitido para esta ronda';
}

class ProblemaNegrasNegativas extends Error implements Exception {
@override
String toString() => 'El numero de cartas negras no pueden ser negativas';
}

class ProblemaRosasNegativas extends Error implements Exception {
@override
String toString() => 'El numero de cartas rosas no pueden ser negativas';
}

class ProblemaDisminucionVerdes extends Error implements Exception {
@override
String toString() => 'El numero que esta ingresando para cartas verdes no puede ser menor a la ronda anterior';
}

class ProblemaDemasiadasRosas extends Error implements Exception {
@override
  String toString() => 'La cantidad de cartas rosas jugadas sobrepasa el limite permitido para esta ronda ';
}

class ProblemaDemasiadasNegras extends Error implements Exception {
@override
  String toString() => 'La cantidad de cartas negras jugadas sobrepasa el limite permitido para esta ronda ';
}