import 'package:partida/partida.dart';
import 'usuario.dart';

abstract class RepositorioIdeal{
  Future<bool> registradoUsuario( { required Usuario u});
  Future<bool> registrarUsuario({ required Usuario u });
  registrarPartida({ required Partida p, required Usuario u});
  Future<List<Partida>> recuperarPartidas({required Usuario u});
  eliminarUsuario({required Usuario usuario});
  verificarInicioSesion({required Usuario usuario});
}