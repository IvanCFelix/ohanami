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
    if(estado is Partida1){
      return VistaPartida1();
    }
    if(estado is Partida2){
      return VistaPartida2();
    }
    if(estado is Partida3){
      return VistaPartida3(); 
    }
    return Container();
  }
}

class VistaPartida1 extends StatelessWidget {
  const VistaPartida1({ Key? key }) : super(key: key);

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
               context.read<OhanamiBloc>().add(Sigientepartida2());
            }, 
            child: Text("Partida 2"),
          )
        ],
      ),
    );
  }
}

class VistaPartida2 extends StatelessWidget {
  const VistaPartida2({ Key? key }) : super(key: key);

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
               context.read<OhanamiBloc>().add(Sigientepartida3());
            }, 
            child: Text("Partida 3"),
          )
        ],
      ),
    );
  }
}

class VistaPartida3 extends StatelessWidget {
  const VistaPartida3({ Key? key }) : super(key: key);

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
              Navigator.push(context, MaterialPageRoute( builder: (context) => DetallePartida() ));
            }, 
            child: Text("Informacion"),
          )
        ],
      ),
    );
  }
}