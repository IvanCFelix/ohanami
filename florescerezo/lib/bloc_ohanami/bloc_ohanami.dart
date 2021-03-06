import 'package:florescerezo/bloc_ohanami/estados.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:partida/partida.dart';

class OhanamiBloc extends Bloc<Evento, Estados_ohanami> {
  OhanamiBloc(this.partida, this.iconosJugadores): super(Ronda1(partida, iconosJugadores)) {
    on<SiguienteRonda1>(_onPartida1);
    on<SiguienteRonda2>(_onPartida2);
    on<SiguienteRonda3>(_onPartida3);
  }
  
  Partida partida;
  List<IconData> iconosJugadores;

  void _onPartida2 (SiguienteRonda2 evento, Emitter<Estados_ohanami> emit){
    partida = evento.partida;
    emit(Ronda2(partida, iconosJugadores));
  }
  
  void _onPartida3 (SiguienteRonda3 evento, Emitter<Estados_ohanami> emit){
    partida = evento.partida;

    emit(Ronda3(partida, iconosJugadores));
  }

  void _onPartida1 (SiguienteRonda1 evento, Emitter<Estados_ohanami> emit){
    partida = evento.partida;

    emit(Ronda1(partida, iconosJugadores));
  }
}
