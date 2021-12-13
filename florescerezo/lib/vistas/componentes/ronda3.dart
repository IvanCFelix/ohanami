import 'package:florescerezo/db/db_local.dart';
import 'package:flutter/material.dart';
import 'package:partida/partida.dart';

import '../detalle_partida.dart';

class VistaRonda3 extends StatelessWidget {
  const VistaRonda3({ Key? key, required this.partida}) : super(key: key);
  final Partida partida;

  Future<bool> actualizar({required Partida partida})async{
    bool check = false;
    RepositorioLocal local = RepositorioLocal();
    check = await local.registrarPartida(partida: partida);
    return check;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text("Partida3"),
          ),
          ElevatedButton(
            onPressed: () async {
            //bool check = await actualizar(partida:);
            //if(check == true){
              Navigator.push(context, MaterialPageRoute( builder: (context) => DetallePartida()));
            //}
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