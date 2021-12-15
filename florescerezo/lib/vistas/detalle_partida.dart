
import 'package:flutter/material.dart';
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
  Partida partida;
  List<charts.Series<CRonda1, String>> _seriesData1 = [];
  List<charts.Series<CRonda2, String>> _seriesData2 = [];
  List<charts.Series<CRonda3, String>> _seriesData3 = [];
  List<PuntuacionJugador> puntuacionesrondaDesenlace = [];
  List<PuntuacionJugador> puntuacionesronda1 = [];
  List<PuntuacionJugador> puntuacionesronda2 = [];
  List<PuntuacionJugador> puntuacionesronda3 = [];
  List<CRonda1> cartasRonda1 = [];
  List<CRonda2> cartasRonda2 = [];
  List<CRonda3> cartasRonda3 = [];

  _DetallePartidaState(this.partida);


  @override
  void initState(){
    super.initState();
    calcularPuntuacionesPartida();
    
  }
  void calcularPuntuacionesPartida(){
    puntuacionesronda1 = partida.puntos(ronda: FasePuntuacion.Ronda1);
    puntuacionesronda2 = partida.puntos(ronda: FasePuntuacion.Ronda2);
    puntuacionesronda3 = partida.puntos(ronda: FasePuntuacion.Ronda3);
    puntuacionesrondaDesenlace = partida.puntos(ronda: FasePuntuacion.desenlace);
  }


  _generarDataR1() {
    _seriesData1.add(
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
    _seriesData2.add(
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
    _seriesData2.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasVerdes ,
        id: '2',
        data: partida.puntuacionesRonda2,
        seriesCategory: '22',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda2 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF33FF41)),
      ), 
    );
  }
  _generarDataR3() {
    _seriesData3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasAzules,
        id: '3',
        data: partida.puntuacionesRonda3,
        seriesCategory: '31',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda3 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF337CFF)),
      ), 
    );
    _seriesData3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasVerdes,
        id: '3',
        data: partida.puntuacionesRonda3,
        seriesCategory: '32',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda3 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF33FF41)),
      ), 
    );
    _seriesData3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasRosas,
        id: '3',
        data: partida.puntuacionesRonda3,
        seriesCategory: '33',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda3 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF870039)),
      ), 
    );
    _seriesData3.add(
      charts.Series(
        domainFn: (partida, _) =>  partida.jugador.nombre.toString(),
        measureFn: (partida, _) =>partida.cuantasNegras,
        id: '3',
        data: partida.puntuacionesRonda3,
        seriesCategory: '34',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (CRonda3 partida, _) =>
            charts.ColorUtil.fromDartColor(Color(0xFF555555)),
      ), 
    );
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push( context, MaterialPageRoute(builder: (context) => VistaListaPartidas()));
        }, 
        icon: Icon(Icons.arrow_back)),
          title: const Text('Informacion de la Partida'),
          bottom: const TabBar(
            tabs: <Widget>[
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
                  Text(partida.toString()),
                  Expanded(
                    child: _graficaRonda1(),
                  ),
                ],
              ),
              Center(
                child: _graficaRonda2(),
              ),
              Center(
                child: _graficaRonda3(),
              ),
            ],
          ),
      ),
    );

  }

 _graficaRonda3(){
   _generarDataR3();
  return Container(
    child: charts.BarChart(
      _seriesData3,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
      animationDuration: Duration(seconds: 1),
    ),
  );
}
 _graficaRonda2(){
   _generarDataR2();
  return Container(
    child: charts.BarChart(
      _seriesData2,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
      animationDuration: Duration(seconds: 1),
    ),
  );
}
 _graficaRonda1(){
   _generarDataR1();
  return Container(
    child: charts.BarChart(
      _seriesData1,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
      animationDuration: Duration(seconds: 1),
    ),
  );
}
}
