import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';
import 'package:florescerezo/bloc_ohanami/estados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detalle_partida.dart';

class Cuerpo extends StatelessWidget {
  const Cuerpo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<OhanamiBloc>().state;
    if(estado is Ronda1){
      return VistaRonda1();
    }
    if(estado is Ronda2){
      return VistaRonda2();
    }
    if(estado is Ronda3){
      return VistaRonda3(); 
    }
    return Container();
  }
}

class VistaRonda1 extends StatelessWidget {
  const VistaRonda1({ Key? key }) : super(key: key);
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
               context.read<OhanamiBloc>().add(SiguienteRonda2());
            }, 
            child: Text("Partida 2"),
          )
        ],
      ),
    );
  }
}

class VistaRonda2 extends StatelessWidget {
  const VistaRonda2({ Key? key }) : super(key: key);

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
               context.read<OhanamiBloc>().add(SiguienteRonda3());
            }, 
            child: Text("Partida 3"),
          )
        ],
      ),
    );
  }
}

class VistaRonda3 extends StatelessWidget {
  const VistaRonda3({ Key? key }) : super(key: key);

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
          )
        ],
      ),
    );
  }
}