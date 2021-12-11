import 'package:florescerezo/bloc_ohanami/estados.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:partida/partida.dart';

class OhanamiBloc extends Bloc<Evento, Estado> {
  OhanamiBloc() : super(Partida1()){
    on<Sigientepartida2>(_onPartida2);
    on<Sigientepartida3>(_onPartida3);
  }
  void _onPartida2 (Sigientepartida2 evento, Emitter<Estado> emit){

    emit(Partida2());
  }
  void _onPartida3 (Sigientepartida3 evento, Emitter<Estado> emit){

    emit(Partida3());
  }
}
