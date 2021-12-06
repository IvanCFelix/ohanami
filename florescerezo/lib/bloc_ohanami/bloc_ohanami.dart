import 'dart:async';

import 'package:florescerezo/bloc_ohanami/estados.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:db_paquete/db_paquete.dart';
import 'package:bloc/bloc.dart';

class BlocOhanami extends Bloc<Evento, Estados_ohanami>{
  Repositorio repositorio;

  BlocOhanami(this.repositorio) : super(Iniciando());

}