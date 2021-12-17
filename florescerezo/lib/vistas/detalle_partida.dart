
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
  List<charts.Series<CRonda1, String>> _seriesData1 = [];
  List<charts.Series<CRonda2, String>> _seriesData2 = [];
  List<charts.Series<CRonda3, String>> _seriesData3 = [];
  List<PuntuacionJugador> prDesenlace = [];
  List<PuntuacionJugador> puntuacionesRondaDesenlace = [];
  List<PuntuacionJugador> puntuacionesronda1 = [];
  List<PuntuacionJugador> puntuacionesronda2 = [];
  List<PuntuacionJugador> puntuacionesronda3 = [];
  List<CRonda1> cartasRonda1 = [];
  List<CRonda2> cartasRonda2 = [];
  List<CRonda3> cartasRonda3 = [];

  List<int> puntos = [50,50,50,50];
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
    _seriesData3.add(
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
    _seriesData3.add(
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
    _seriesData3.add(
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
    _seriesData3.add(
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
                    child: _graficaRonda1(),
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
                    child: _graficaRonda2(),
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
                    child: _graficaRonda3(),
                  ),
                  
                ],
              ),
            ],
          ),
      ),
    );
  }

_graficaRonda3(){
  return Container(
    color: Colors.white,
    child: charts.BarChart(
      _seriesData3,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 1),
    ),
  );
}
_graficaRonda2(){
  return Container(
    color: Colors.white,
    child: charts.BarChart(
      _seriesData2,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      animationDuration: Duration(seconds: 1),
    ),
  );
}
_graficaRonda1(){
  return Container(
    color: Colors.white,
    height: 60,
    child: charts.BarChart(
      _seriesData1,
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
                  child: Text(puntos == 50? "0" : puntos.toString()+" pts",
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
        height: puntos <= 50 ? 60 : puntos.toDouble()*0.5,
        curve: Curves.ease,
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
