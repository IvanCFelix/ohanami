
import 'package:florescerezo/estilos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:partida/partida.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'lista_partida.dart';
class DetallePartida extends StatefulWidget {
  const DetallePartida({Key? key, required this.partida}) : super(key: key);
  final Partida partida;

  @override
  _DetallePartidaState createState() => _DetallePartidaState(partida);
}

class _DetallePartidaState extends State<DetallePartida> {
  _DetallePartidaState(this.partida);
  Partida partida;
  List<charts.Series<CRonda1, String>> _seriesCartas1 = [];
  List<charts.Series<CRonda2, String>> _seriesCartas2 = [];
  List<charts.Series<CRonda3, String>> _seriesCartas3 = [];
  List<charts.Series<PuntuacionJugador, String>> _seriesPuntosTotales = [];
  List<charts.Series<PuntuacionJugador, String>> _seriesPuntos1 = [];
  List<charts.Series<PuntuacionJugador, String>> _seriesPuntos2 = [];
  List<charts.Series<PuntuacionJugador, String>> _seriesPuntos3 = [];
  
  List<PuntuacionJugador> prDesenlace = [];
  List<PuntuacionJugador> puntuacionesRondaDesenlace = [];
  List<PuntuacionJugador> puntuacionesronda1 = [];
  List<PuntuacionJugador> puntuacionesronda2 = [];
  List<PuntuacionJugador> puntuacionesronda3 = [];
  List<CRonda1> cartasRonda1 = [];
  List<CRonda2> cartasRonda2 = [];
  List<CRonda3> cartasRonda3 = [];

  List<int> puntos = [30,30,30,30];
  List<Color> colores = [Colors.grey,Colors.grey,Colors.grey,Colors.grey];
  List<String> nombres = [" ? "," ? "," ? "," ? ",];


  @override
  void initState(){
    super.initState();
    calcularPuntuacionesPartida();  
    ordenar();
    _generarDataR1();
    _generarDataR2();
    _generarDataR3();
    _puntosTotales();
    _puntosRonda1();
    _puntosRonda2();
    _puntosRonda3();
  }

  void calcularPuntuacionesPartida(){
    puntuacionesronda1 = partida.puntos(ronda: FasePuntuacion.Ronda1);
    puntuacionesronda2 = partida.puntos(ronda: FasePuntuacion.Ronda2);
    puntuacionesronda3 = partida.puntos(ronda: FasePuntuacion.Ronda3);
    prDesenlace = partida.puntos(ronda: FasePuntuacion.desenlace);
    puntuacionesRondaDesenlace = partida.puntos(ronda: FasePuntuacion.desenlace);
  }

   void  ordenar(){
     puntuacionesRondaDesenlace.sort((a, b) => a.total.compareTo(b.total));
     var listaRevez = puntuacionesRondaDesenlace.reversed;
     print(listaRevez.elementAt(0).total);
     Future.delayed(Duration(seconds: 2)).then((value) => setState(() {
     for (var i = 0; i < listaRevez.length; i++) {
       puntos.insert(i, listaRevez.elementAt(i).total);
       nombres.insert(i, listaRevez.elementAt(i).jugador.nombre);
     }
     colores.insert(0,secondaryDarkColor); 
    }));
  }


  _generarDataR1() {
    _seriesCartas1.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasAzules ,
        id: '1',
        data: partida.puntuacionesRonda1,
        seriesCategory: '1',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda1 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF337CFF)),
      ), 
    );
  }
  _generarDataR2() {
    _seriesCartas2.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasAzules ,
        id: '2',
        data: partida.puntuacionesRonda2,
        seriesCategory: '21',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda2 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF337CFF)),
      ), 
    );
    _seriesCartas2.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasVerdes ,
        id: '3',
        data: partida.puntuacionesRonda2,
        seriesCategory: '22',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda2 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF33FF41)),
      ), 
    );
  }
  _generarDataR3() {
    _seriesCartas3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasAzules,
        id: '4',
        data: partida.puntuacionesRonda3,
        seriesCategory: '31',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda3 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF337CFF)),
      ), 
    );
    _seriesCartas3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasVerdes,
        id: '5',
        data: partida.puntuacionesRonda3,
        seriesCategory: '32',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda3 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF33FF41)),
      ), 
    );
    _seriesCartas3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasRosas,
        id: '6',
        data: partida.puntuacionesRonda3,
        seriesCategory: '33',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda3 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFFBE2A7C)),
      ), 
    );
    _seriesCartas3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasNegras,
        id: '7',
        data: partida.puntuacionesRonda3,
        seriesCategory: '34',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda3 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF555555)),
      ), 
    );
  }

  _puntosTotales(){
    _seriesPuntosTotales.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porAzules ,
        id: '1',
        data: puntuacionesronda1,
        seriesCategory: '1',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF337CFF)),
      ), 
    );
    _seriesPuntosTotales.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porVerdes ,
        id: '1',
        data: puntuacionesronda2,
        seriesCategory: '2',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF33FF41)),
      ), 
    );
    _seriesPuntosTotales.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porRosas ,
        id: '1',
        data: puntuacionesronda3,
        seriesCategory: '3',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFFBE2A7C)),
      ), 
    );
    _seriesPuntosTotales.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porNegras ,
        id: '1',
        data: puntuacionesronda3,
        seriesCategory: '4',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF555555)),
      ), 
    );
  }

  _puntosRonda1(){
    _seriesPuntos1.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porAzules,
        id: '1',
        data: puntuacionesronda1,
        seriesCategory: '1',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF337CFF)),
      ), 
    );
  }

  _puntosRonda2(){
    _seriesPuntos2.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porAzules,
        id: '1',
        data: puntuacionesronda2,
        seriesCategory: '1',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF337CFF)),
      ), 
    );
    _seriesPuntos2.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) => partida.porVerdes,
        id: '1',
        data: puntuacionesronda2,
        seriesCategory: '2',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF33FF41)),
      ), 
    );
  }

  _puntosRonda3(){
    _seriesPuntos3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porAzules,
        id: '1',
        data: puntuacionesronda3,
        seriesCategory: '1',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF337CFF)),
      ), 
    );
    _seriesPuntos3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) => partida.porVerdes,
        id: '1',
        data: puntuacionesronda3,
        seriesCategory: '2',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF33FF41)),
      ), 
    );
    _seriesPuntos3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porRosas ,
        id: '1',
        data: puntuacionesronda3,
        seriesCategory: '3',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFFBE2A7C)),
      ), 
    );
    _seriesPuntos3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.porNegras ,
        id: '1',
        data: puntuacionesronda3,
        seriesCategory: '4',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (PuntuacionJugador partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF555555)),
      ), 
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        backgroundColor:secondaryLightColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(onPressed: (){
          Navigator.push( context, MaterialPageRoute(builder: (context) => VistaListaPartidas()));
        }, 
        icon: Icon(Icons.arrow_back)),
          title: const Text('Informacion de la Partida'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(FontAwesomeIcons.crown),
              ),
              Tab(
                icon: Icon(Icons.looks_one),
              ),
              Tab(
                icon: Icon(Icons.looks_two),
              ),
              Tab(
                icon: Icon(Icons.looks_3),
              ),
            ],
          ),
      ),
      body:TabBarView(
            children: <Widget>[
              Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(child:_vista(puntos[0], colores[0], nombres[0], FontAwesomeIcons.crown)),
                            Expanded(child:_perdedores(prDesenlace.length-1)
                            )
                          ],
                        )
                      ),
                  )),
                  Expanded(
                    flex: 2,
                    child: Container(
                    color: Colors.yellowAccent,
                    child: Column(
                      children: [
                        Expanded(child: _graficaPuntosTotales()
                        )
                      ],
                    ),
                  ))
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Cantidad de cartas de la ronda 1",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: _graficaCartasRonda1(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Cantidad de cartas de la ronda 1",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: _graficaPuntosRonda1(),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Cantidad de cartas de la ronda 2",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: _graficaCartasRonda2(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Cantidad de puntos de la ronda 2",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: _graficaPuntosRonda2(),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Cantidad de cartas de la ronda 3",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: _graficaCartasRonda3(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Cantidad de puntos de la ronda 3",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: _graficaPuntosRonda3(),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }

_graficaCartasRonda3(){
  return Container(
    color: Colors.white,
    child: charts.BarChart(
      _seriesCartas3,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 1),
    ),
  );
}

_graficaCartasRonda2(){
  return Container(
    color: Colors.white,
    child: charts.BarChart(
      _seriesCartas2,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 1),
    ),
  );
}

_graficaCartasRonda1(){
  return Container(
    color: Colors.white,
    height: 60,
    child: charts.BarChart(
      _seriesCartas1,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 1),
    ),
  );
}

_graficaPuntosTotales(){
    return Container(
    color: Colors.white,
    height: 60,
    child: charts.BarChart(
      _seriesPuntosTotales,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 5),
    ),
  );
}

_graficaPuntosRonda1(){
    return Container(
    color: Colors.white,
    height: 60,
    child: charts.BarChart(
      _seriesPuntos1,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 1),
    ),
  );
}

_graficaPuntosRonda2(){
    return Container(
    color: Colors.white,
    height: 60,
    child: charts.BarChart(
      _seriesPuntos2,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 1),
    ),
  );
}

_graficaPuntosRonda3(){
    return Container(
    color: Colors.white,
    height: 60,
    child: charts.BarChart(
      _seriesPuntos3,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 1),
    ),
  );
}

_vista(puntos, color, nombre, icon){
    return Center(
      child: AnimatedContainer(
          child: Row(
            children: [
              Expanded(child: Container(
                child:Center(child: Icon(icon)),
              )
              ),
              Expanded(child: Container(
                child: Center(
                  child: Text(nombre,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                  ),
                ),
              )
              ),
              Expanded(child: Container(
                child: Center(
                  child: Text(puntos == 30? "0" : puntos.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                  ),
                ),
                )
              )
            ]
          ),
        duration: Duration(milliseconds:1000),
        width: 200,
        height: puntos <= 30 ? 30 : puntos.toDouble()*0.5,
        curve: Curves.easeOutCirc,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color
        ), 

      ),
    );
  }

_perdedores(perdedores){
    switch (perdedores) {
      case 1: 
      return Column(
        children: [
          Expanded(child:_vista(puntos[1], colores[1], nombres[1], FontAwesomeIcons.ghost) ),
        ],
      );
      case 2: 
      return Column(
        children: [
          Expanded(child:_vista(puntos[1], colores[1], nombres[1], FontAwesomeIcons.ghost) ),
          Expanded(child:_vista(puntos[2], colores[2], nombres[2], FontAwesomeIcons.ghost) )
        ],
      );
      case 3: 
      return Column(
        children: [
          Expanded(child:_vista(puntos[1], colores[1], nombres[1], FontAwesomeIcons.ghost) ),
          Expanded(child:_vista(puntos[2], colores[2], nombres[2], FontAwesomeIcons.ghost) ),
          Expanded(child:_vista(puntos[3], colores[3], nombres[3], FontAwesomeIcons.ghost) )
        ],
      );
    }
  }

}
