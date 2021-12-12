import 'package:flutter/material.dart';
import 'package:partida/partida.dart';

import '../detalle_partida.dart';

class VistaRonda3 extends StatelessWidget {
  const VistaRonda3({ Key? key, required this.partida}) : super(key: key);
  final Partida partida;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text("Partida3"),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute( builder: (context) => DetallePartida(check:false) ));
            }, 
            child: Text("Informacion"),
          ),
          Text("Aqui esta la partida"),
          Text(partida.toString()),
        ],
      ),
    );
  }
}