import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:partida/partida.dart';
/*
class Estado{}

class Ronda1 extends Estado{}
class Ronda2 extends Estado{}
class Ronda3 extends Estado{}
*/

part 'estados.freezed.dart';

@freezed
class Estados_ohanami with _$Estados_ohanami{
  const factory Estados_ohanami.ronda1(Partida partida) = Ronda1;
  const factory Estados_ohanami.ronda2(Partida partida) = Ronda2;
  const factory Estados_ohanami.ronda3(Partida partida) = Ronda3;
}
