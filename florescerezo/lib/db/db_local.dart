import 'dart:convert';
import 'package:db_paquete/db_paquete.dart';
import 'package:partida/src/partida.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RepositorioLocal extends Repositorio{
  
  Future<bool> guardarUsuario(Usuario usuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check;
    check = await prefs.setString('usuario', jsonEncode(usuario.toJson())).then((bool success) {
        return success;
      });
    return check;
  }
  Future<Usuario> regresarUsuario() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    var usuarioJson = jsonDecode(respuesta!);
    Usuario usuario = Usuario.fromJson(usuarioJson);
    
    return usuario;
  }

  @override
  Future<bool> eliminarUsuario({required Usuario usuario}) {
    // TODO: implement eliminarUsuario
    throw UnimplementedError();
  }

  @override
  Future<List<Partida>> recuperarPartidas({required Usuario usuario}) {
    // TODO: implement recuperarPartidas
    throw UnimplementedError();
  }

  @override
  Future<bool> reescribirPartidas({required Usuario usuario}) {
    // TODO: implement reescribirPartidas
    throw UnimplementedError();
  }

  @override
  Future<bool> registradoUsuario({required Usuario usuario}) {
    // TODO: implement registradoUsuario
    throw UnimplementedError();
  }

  @override
  Future<bool> registrarPartida({required Partida partida, required Usuario usuario}) {
    // TODO: implement registrarPartida
    throw UnimplementedError();
  }

  @override
  Future<bool> registrarUsuario({required Usuario usuario}) {
    // TODO: implement registrarUsuario
    throw UnimplementedError();
  }

  @override
  Future<bool> verificarInicioSesion({required Usuario usuario}) {
    // TODO: implement verificarInicioSesion
    throw UnimplementedError();
  }


}