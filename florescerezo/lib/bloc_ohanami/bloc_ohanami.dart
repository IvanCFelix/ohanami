import 'package:florescerezo/bloc_ohanami/estados.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:partida/partida.dart';

class OhanamiBloc extends Bloc<Evento, Estado> {
  OhanamiBloc() : super(Ronda1()){
    on<SiguienteRonda2>(_onPartida2);
    on<SiguienteRonda3>(_onPartida3);
  }
  void _onPartida2 (SiguienteRonda2 evento, Emitter<Estado> emit){

    emit(Ronda2());
  }
  void _onPartida3 (SiguienteRonda3 evento, Emitter<Estado> emit){

    emit(Ronda3());
  }
}
