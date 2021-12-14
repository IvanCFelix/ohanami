
import 'package:florescerezo/db/db_local.dart';
import 'package:flutter/material.dart';
import 'package:partida/partida.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'lista_partida.dart';
import 'nuevapartida.dart';
class DetallePartida extends StatefulWidget {
  const DetallePartida({Key? key, required this.partida}) : super(key: key);
  final Partida partida;

  @override
  _DetallePartidaState createState() => _DetallePartidaState(partida);
}

class _DetallePartidaState extends State<DetallePartida> {
  Partida partida;
  List<charts.Series<Partida, String>> _infromacionPartida = [];
  int i =0;


  _DetallePartidaState(this.partida);


  @override
  void initState(){
    super.initState();
    calcularPuntuacionesPartida();
    
  }
  void calcularPuntuacionesPartida(){
    List<PuntuacionJugador> j;
    partida.puntos(ronda: FasePuntuacion.Ronda1);
    partida.puntos(ronda: FasePuntuacion.Ronda2);
    partida.puntos(ronda: FasePuntuacion.Ronda3);
    j = partida.puntos(ronda: FasePuntuacion.desenlace);
    print(j[2].total);
  }
  @override
  Widget build(BuildContext context) {
    
    return 
        Scaffold(
          floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_library_add_outlined),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute( builder: (context) => NuevaPartida()));
          }
        ),
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: Text("Detalle Partida"),
          ),
          body:Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
                        child: Column(
                          children:[
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(partida.toString()),
                                ),
                              ),
                            ),
                            posiciones(),
                            Container(
                              
                              child: Text(
                                  'Cartas',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: 
                                    FontWeight.bold),
                                    ),
                            ),
                            Container(
                              child: Expanded(
                                child: charts.BarChart(
                                  _infromacionPartida,
                                  animate: true,
                                  barGroupingType: charts.BarGroupingType.groupedStacked,
                                  animationDuration: Duration(seconds: 1),
                                ),
                              ),
                            ),
                            descripcion(),
                          ],
                        ),
                      ),
                    ),
                  ),
    ); 
  }
Widget posiciones(){
  return Container(
    child: Row(
    children: [
        Expanded(
          flex: 1,
          child: Container(
            child:primerlugar('Alfonso', '62 pts', 'Primero')
        ),
        ),
        SizedBox(
          height: 1,
          width: 1,
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: Column(
                children: [
                  perdedores('Pedro', '41 pts', 'segundo'),
                ],
              )
                    ),
                  ),
                ),
              ],
            ),
        ) 
        ),
      ],
    ),
  );
}
}

Widget primerlugar(String nombre, puntos, posicion){
  return Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(nombre,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(puntos,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                        )
                        ),
                      ),
                    ],
                  ),
                ],
              )
            );
}

Widget perdedores(String nombre, puntos, posicion){
  return                 Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(nombre,
                      style: TextStyle(
                        color: Colors.white
                      ),),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Text(puntos,
                    style: TextStyle(
                        color: Colors.white
                    )
                    ),
                  ),
                ],
              )
                    ),
                  ),
                );
}


Widget descripcion(){
  return Container(
    child: Column(
      children: [
        Table(

          children: [
            TableRow(
              children:[
              Text('Azules:'),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
                color: Color(0xFF060F32),
              ),
              Text('Ronda 1'),
              ],
              ),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
                color: Color(0xFF0F278A),
              ),
              Text('Ronda 2'),
              ],
              ),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
                color: Color(0xFF337CFF),
              ),
              Text('Ronda 3'),
              ],
              ),
              ]
            ),
          ],
        ),
        Table(
          children: [
            TableRow(
              children:[
              Text('Verdes:'),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
                color: Color(0xFF044B00),
              ),
              Text('Ronda 2'),
              ],
              ),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
                color: Color(0xFF0BE700),
              ),
              Text('Ronda 3'),
              ],
              ),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
              ),
              ],
              ),
              ]
            ),
          ],
        ),
        Table(
          children: [
            TableRow(
              children:[
              Text('Rosas:'),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
                color: Color(0xFFE42390),
              ),
              Text('Ronda 3'),
              ],
              ),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
              ),
              ],
              ),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
              ),
              ],
              ),
              ]
            ),
          ],
        ),
        Table(
          children: [
            TableRow(
              children:[
              Text('Negras:'),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
                color: Color(0xFF4C4C4C),
              ),
              Text('Ronda 3'),
              ],
              ),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
              ),
              ],
              ),
              Row(
                children: [
              Container(
                height: 20,
                width: 20,
              ),
              ],
              ),
              ]
            ),
          ],
        ),
      ],
    ),
  );
}