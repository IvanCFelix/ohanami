import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'componentes/vista_ronda_1.dart';
import 'componentes/vista_ronda_2.dart';
import 'componentes/vista_ronda_3.dart';

class VistaDinamica extends StatelessWidget {
  const VistaDinamica({ Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final estado = context.watch<OhanamiBloc>().state;
    return estado.map(
      ronda1: (Ronda1) => VistaRonda1(partida: Ronda1.partida, iconosJugadores: Ronda1.iconos,), 
      ronda2: (Ronda2) => VistaRonda2(partida: Ronda2.partida, iconosJugadores: Ronda2.iconos,), 
      ronda3: (Ronda3) => VistaRonda3(partida: Ronda3.partida, iconosJugadores: Ronda3.iconos,),
      );
  }
}