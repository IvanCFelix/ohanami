import 'package:partida/partida.dart';
import 'usuario.dart';

abstract class RepositorioIdeal{
  Future<bool> registradoUsuario( { required Usuario usuario});
  Future<bool> registrarUsuario({ required Usuario usuario });
  registrarPartida({ required Partida p, required Usuario usuario});
  Future<List<Partida>> recuperarPartidas({required Usuario usuario});
  eliminarUsuario({required Usuario usuario});
  Future<bool> verificarInicioSesion({required Usuario usuario});
  eliminarPartida({ required Partida p, required Usuario usuario});
}