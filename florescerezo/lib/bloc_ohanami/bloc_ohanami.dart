import 'package:florescerezo/bloc_ohanami/estados.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class OhanamiBloc extends Bloc<Evento, Estado> {
  OhanamiBloc() : super(Iniciando()){
  //on<Inicializado>(_onInicializado2 );
  on<Entrar>(_onLogin);
  }
}

  void _onLogin (Entrar evento, Emitter<Estado> emit) {
  emit(Login());
  }