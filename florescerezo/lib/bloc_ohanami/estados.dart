import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:partida/partida.dart';

part 'estados.freezed.dart';

@freezed
class Estados_ohanami with _$Estados_ohanami{
  const factory Estados_ohanami.ronda1(Partida partida, List<IconData> iconos) = Ronda1;
  const factory Estados_ohanami.ronda2(Partida partida, List<IconData> iconos) = Ronda2;
  const factory Estados_ohanami.ronda3(Partida partida, List<IconData> iconos) = Ronda3;
}