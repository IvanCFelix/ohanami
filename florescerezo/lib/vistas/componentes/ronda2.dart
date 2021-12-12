import 'package:flutter/material.dart';
import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';

import 'package:partida/partida.dart';
import 'package:provider/src/provider.dart';
class VistaRonda2 extends StatelessWidget {
  const VistaRonda2({ Key? key, required this.partida}) : super(key: key);
  final Partida partida; 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text("Partida2"),
          ),
          ElevatedButton(
            onPressed: (){
               context.read<OhanamiBloc>().add(SiguienteRonda3(partida: partida));
            }, 
            child: Text("Partida 3"),
            
          ),
          Text("Aqui esta la partida"),
          Text(partida.toString()),
        ],
      ),
    );
  }
}
