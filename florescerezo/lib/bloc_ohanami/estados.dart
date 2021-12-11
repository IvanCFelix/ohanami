import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class Estado{}

class Partida1 extends Estado{}
class Partida2 extends Estado{}
class Partida3 extends Estado{}

/*
part 'estados.freezed.dart';

@freezed
class Estados_ohanami with _$Estados_ohanami{
  const factory Estados_ohanami() = Iniciando;
  const factory Estados_ohanami.doLogin({String? email, String? pass}) = Login;
  const factory Estados_ohanami.doLogout() = Logout;
}
*/