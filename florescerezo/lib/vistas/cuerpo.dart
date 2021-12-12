import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partida/partida.dart';
import 'ronda1.dart';
import 'ronda2.dart';
import 'ronda3.dart';

class Cuerpo extends StatelessWidget {
  const Cuerpo({ Key? key, required this.partida }) : super(key: key);
  final Partida partida;
  @override
  Widget build(BuildContext context) {
    final estado = context.watch<OhanamiBloc>().state;
    return estado.map(
      ronda1: (Ronda1) => VistaRonda1(partida: partida,), 
      ronda2: (Ronda2) => VistaRonda2(partida: partida,), 
      ronda3: (Ronda3) => VistaRonda3(partida: partida,),
      );
  }
}