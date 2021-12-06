
import 'package:partida/partida.dart';
import 'usuario.dart';

abstract class Repositorio{
  Future<bool> registradoUsuario( { required Usuario usuario});
  Future<bool> registrarUsuario({ required Usuario usuario });
  Future<bool> registrarPartida({ required Partida partida, required Usuario usuario});
  Future<List<Partida>> recuperarPartidas({required Usuario usuario});
  Future<bool> eliminarUsuario({required Usuario usuario});
  Future<bool> verificarInicioSesion({required Usuario usuario});
  Future<bool> reescribirPartidas({ required Usuario usuario});
}
