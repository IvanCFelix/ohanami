import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/vistas/vista_dinamica.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partida/partida.dart';

import '../main.dart';


class Vista_Bloc extends StatelessWidget {
  const Vista_Bloc({Key? key, required this.partida, required this.iconosJugadores}) : super(key: key);
  final Partida partida;
  final List<IconData> iconosJugadores;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OhanamiBloc(partida, iconosJugadores ),
      child: MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: VistaDinamica(),
      ),
    ),
    );
  }
}
