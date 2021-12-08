import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/vistas/cuerpo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Blocvista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OhanamiBloc(),
      child: MiAplicacion(),
    );
  }

}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bloc"),
        ),
        body: Cuerpo(),
      ),
    );
  }
}
