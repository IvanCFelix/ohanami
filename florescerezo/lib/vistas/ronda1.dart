import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';
import 'package:flutter/material.dart';
import 'package:partida/partida.dart';
import 'package:provider/src/provider.dart';

class VistaRonda1 extends StatelessWidget {
  const VistaRonda1({ Key? key, required this.partida}) : super(key: key);
  final Partida partida; 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text("Partida1"),
          ),
          ElevatedButton(
            onPressed: (){
               context.read<OhanamiBloc>().add(SiguienteRonda2( partida: partida ));
            }, 
            child: Text("Partida 2"),
          )
        ],
      ),
    );
  }
}