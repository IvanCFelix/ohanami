import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partida/partida.dart';
import 'componentes/ronda1.dart';
import 'componentes/ronda2.dart';
import 'componentes/ronda3.dart';

class Cuerpo extends StatelessWidget {
  const Cuerpo({ Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final estado = context.watch<OhanamiBloc>().state;
    return estado.map(
      ronda1: (Ronda1) => VistaRonda1(partida: Ronda1.partida,), 
      ronda2: (Ronda2) => VistaRonda2(partida: Ronda2.partida,), 
      ronda3: (Ronda3) => VistaRonda3(partida: Ronda3.partida,),
      );
  }
}