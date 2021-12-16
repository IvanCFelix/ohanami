import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/vistas/cuerpo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partida/partida.dart';

import '../main.dart';


class Blocvista extends StatelessWidget {
  const Blocvista({Key? key, required this.partida, required this.iconosJugadores}) : super(key: key);
  final Partida partida;
  final List<IconData> iconosJugadores;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OhanamiBloc(partida, iconosJugadores ),
      child: MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Cuerpo(),
      ),
    ),
    );
  }
}
