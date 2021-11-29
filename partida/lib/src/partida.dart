import 'package:partida/partida.dart';
import 'package:partida/src/helpers.dart';
import 'package:partida/src/puntuacion_jugador.dart';
import 'puntuaciones.dart';
const numeroMaximoJugadores = 4;
const numeroMinimoJugadores = 2;
const maximoCartasR2 = 20;
const maximoCartasR3 = 30;
//const maximoCartasR1 = 10;
const puntosPorAzules = 3;
const puntosPorVerdes = 4;
const puntosPorNegras = 7;
enum FasePuntuacion{Ronda1, Ronda2, Ronda3, desenlace}

class Partida{
  Partida({required this.jugadores}){
    if (jugadores.length < numeroMinimoJugadores) throw ProblemaNumeroJugadoresMenorMinimo();
    if (jugadores.length > numeroMaximoJugadores) throw ProblemaNumeroJugadoresMayorMaximo();
  }
  
  final Set<Jugador> jugadores;
  List<PRonda1> _puntuacionesRonda1 = [];
  List<PRonda2> _puntuacionesRonda2 = [];
  List<PRonda3> _puntuacionesRonda3 = [];
  var puntosRosas = {0,1,3,6,10,15,21,28,36,45,55,66,78,91,105,120}.toList();
  
  ///Regresa una Lista de [PuntuacionJugador] con las puntuaciones espefificas de la ronda que le mandes como parametro
  List<PuntuacionJugador> puntos({required FasePuntuacion ronda}){
  List<PuntuacionJugador> _PJ = [];
      switch (ronda) {
        case FasePuntuacion.Ronda1:
        for (var i in _puntuacionesRonda1) {
          _PJ.add(PuntuacionJugador(
            jugador: i.jugador, 
            porAzules: i.cuantasAzules * puntosPorAzules, 
            porVerdes: 0, 
            porRosas: 0, 
            porNegras: 0,
            ));
        }
        return _PJ;

        case FasePuntuacion.Ronda2:


        for (var i in _puntuacionesRonda2) {
          _PJ.add(PuntuacionJugador(
            jugador: i.jugador, 
            porAzules: i.cuantasAzules * puntosPorAzules, 
            porVerdes: i.cuantasVerdes * puntosPorVerdes, 
            porRosas: 0, 
            porNegras: 0,
            ));
        }
        return _PJ;

        case FasePuntuacion.Ronda3:

        for (var i in _puntuacionesRonda3) {
          _PJ.add(PuntuacionJugador(
            jugador: i.jugador,
            porAzules:i.cuantasAzules*puntosPorAzules, 
            porVerdes:i.cuantasVerdes*puntosPorVerdes, 
            porRosas: i.cuantasRosas > 15
                  ? 120
                  : puntosRosas[i.cuantasRosas],
            porNegras:i.cuantasNegras*puntosPorNegras,
            ));
        }

        return _PJ;
        case FasePuntuacion.desenlace:
        for (Jugador j in jugadores) {
          int azules = puntos(ronda: FasePuntuacion.Ronda1)
          .firstWhere((element) => element.jugador == j)
          .porAzules +
          puntos(ronda: FasePuntuacion.Ronda2)
          .firstWhere((element) => element.jugador == j)
          .porAzules +
          puntos(ronda: FasePuntuacion.Ronda3)
          .firstWhere((element) => element.jugador == j)
          .porAzules;

          int verdes = puntos(ronda: FasePuntuacion.Ronda1) 
          .firstWhere((element) => element.jugador == j)
          .porVerdes+
          puntos(ronda: FasePuntuacion.Ronda2)
          .firstWhere((element) => element.jugador == j)
          .porVerdes+
          puntos(ronda: FasePuntuacion.Ronda3)
          .firstWhere((element) => element.jugador == j)
          .porVerdes;

          int rosas = puntos(ronda: FasePuntuacion.Ronda1) 
          .firstWhere((element) => element.jugador == j)
          .porRosas+
          puntos(ronda: FasePuntuacion.Ronda2)
          .firstWhere((element) => element.jugador == j)
          .porRosas+
          puntos(ronda: FasePuntuacion.Ronda3)
          .firstWhere((element) => element.jugador == j)
          .porRosas;

          int negras = puntos(ronda: FasePuntuacion.Ronda1) 
          .firstWhere((element) => element.jugador == j)
          .porNegras+
          puntos(ronda: FasePuntuacion.Ronda2)
          .firstWhere((element) => element.jugador == j)
          .porNegras+
          puntos(ronda: FasePuntuacion.Ronda3)
          .firstWhere((element) => element.jugador == j)
          .porNegras;

        _PJ.add(PuntuacionJugador(jugador: j, porAzules: azules, porVerdes: verdes, porRosas: rosas, porNegras: negras));

        }
        return _PJ;
      }
  }
  
  ///Guarda los datos de la primera ronda de puntuación de Ohanami
  ///
  ///En caso de que los jugadores de la puntuacion no coincidan con los
  ///del juego tira [ProblemaJugadoresNoConcuerdan]
  ///
  ///No se puede ingresar mas de 10 cartas azules, de lo contrario arrojara [ProblemaDemasiadasAzules]
  void cartasRonda1(List<PRonda1> puntuaciones){
    Set<Jugador> jugadoresR1 = puntuaciones.map((e) => e.jugador).toSet();
    if(!setEquals(jugadores,jugadoresR1))throw ProblemaJugadoresNoConcuerdan();

    _puntuacionesRonda1 = puntuaciones; 
  }
  
  ///Guarda los datos de la segunda ronda de puntuación de Ohanami
  ///
  ///En caso de que los jugadores de la puntuacion no coincidan con los del juego tira [ProblemaJugadoresNoConcuerdan]
  ///
  ///[cartasRonda2] debe ser llamada despues de la [cartasRonda1] de lo contrario el juego disparara [ProblemaOrdenIncorrecto]
  ///
  ///No se puede ingresar mas de 20 en total, en su defecto arrojara [ProblemaExcesoCartas]
  ///
  ///No puedes ingresar un numero menor de cartas al de la ronda anterior puesto que se lanzara [ProblemaDisminucionAzules] 
  void cartasRonda2(List<PRonda2> puntuaciones){
    if(_puntuacionesRonda1.isEmpty) throw ProblemaOrdenIncorrecto();

    Set<Jugador> jugadoresR2 = puntuaciones.map((e) => e.jugador).toSet();
    if(!setEquals(jugadores,jugadoresR2))throw ProblemaJugadoresNoConcuerdan();
    
    for(PRonda2 segundaPuntuacion in puntuaciones){
      PRonda1 primeraPuntuacion = _puntuacionesRonda1.firstWhere((element) => 
      element.jugador == segundaPuntuacion.jugador);
      if (primeraPuntuacion.cuantasAzules > segundaPuntuacion.cuantasAzules){
        throw ProblemaDisminucionAzules();
      }
    }

    for(PRonda2 p in puntuaciones ){
      if ( p.cuantasAzules > maximoCartasR2) throw ProblemaDemasiadasAzules();
      if ( p.cuantasVerdes > maximoCartasR2) throw ProblemaDemasiadasVerdes(); 
      if ( (p.cuantasAzules + p.cuantasVerdes) > maximoCartasR2) throw ProblemaExcesoCartas();
    }

    _puntuacionesRonda2 = puntuaciones;
  }

  ///Guarda los datos de la tercera ronda de puntuación de Ohanami
  ///
  ///En caso de que los jugadores de la puntuacion no coincidan con los del juego tira [ProblemaJugadoresNoConcuerdan]
  ///
  ///[cartasRonda2] debe ser llamada despues de la [cartasRonda1] de lo contrario el juego disparara [ProblemaOrdenIncorrecto]
  ///
  ///No se puede ingresar mas de 30 en total, en su defecto lanzara [ProblemaExcesoCartas]
  ///
  ///No puedes ingresar un numero menor de cartas al de la ronda anterior puesto que se lanzara [ProblemaDisminucionAzules] y/o [ProblemaDisminucionVerdes]
  void cartasRonda3(List<PRonda3> puntuaciones){

    if (_puntuacionesRonda2.isEmpty) throw ProblemaOrdenIncorrecto();

    Set<Jugador> jugadoresR3 = puntuaciones.map((e) => e.jugador).toSet();
    if(!setEquals(jugadores,jugadoresR3))throw ProblemaJugadoresNoConcuerdan();

    for(PRonda3 terceraPuntuacion in puntuaciones){
      PRonda2 segundaPuntuacion = _puntuacionesRonda2.firstWhere((element) => 
      element.jugador == terceraPuntuacion.jugador);
      if(segundaPuntuacion.cuantasAzules > terceraPuntuacion.cuantasAzules){
        throw ProblemaDisminucionAzules();
      }
      if(segundaPuntuacion.cuantasVerdes > terceraPuntuacion.cuantasVerdes){
        throw ProblemaDisminucionVerdes();
      }
    }
    for(PRonda3 p in puntuaciones ){
      if ( p.cuantasAzules > maximoCartasR3) throw ProblemaDemasiadasAzules();
      if ( p.cuantasVerdes > maximoCartasR3) throw ProblemaDemasiadasVerdes();
      if ( p.cuantasRosas > maximoCartasR3) throw ProblemaDemasiadasRosas();
      if ( p.cuantasNegras > maximoCartasR3) throw ProblemaDemasiadasNegras();
      if ( (p.cuantasAzules + p.cuantasVerdes + p.cuantasRosas + p.cuantasNegras) > maximoCartasR3) throw ProblemaExcesoCartas();
    }
    _puntuacionesRonda3 = puntuaciones;
  }
}


