import 'dart:convert';
import 'package:db_paquete/db_paquete.dart';
import 'package:partida/src/partida.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RepositorioLocal{
  
  Future<bool> eliminarUsuario() async {
    bool check = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    check = await prefs.clear().then((bool success) {
        return success;
      });
    return check;
  }

  Future<List<Partida>> recuperarPartidas() async {
    List<Partida> partidas;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    var usuarioJson = jsonDecode(respuesta!);
    Usuario usuario = Usuario.fromJson(usuarioJson);
    return partidas = usuario.partidas;
  }

  Future<bool> registradoUsuario() async {
    late bool check;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    if (respuesta == null){
     return check = false;
    }
    return check = true;
  }

  Future<bool> registrarPartida({required Partida partida}) async {
    bool check;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    var usuarioJson = jsonDecode(respuesta!);
    Usuario usuario = Usuario.fromJson(usuarioJson);
    usuario.partidas.add(partida);
    check = await registrarUsuario(usuario: usuario);
    return check;
  }


  Future<bool> registrarUsuario({required Usuario usuario}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check;
    check = await prefs.setString('usuario', jsonEncode(usuario.toJson())).then((bool success) {
        return success;
      });
    return check;
  }
  
  Future<Usuario> recuperarUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    var usuarioJson = jsonDecode(respuesta!);
    Usuario usuario = Usuario.fromJson(usuarioJson);
    return usuario;
  }
    
  Future<bool> reescribirUsuario({required Usuario usuario})async{
    bool check = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    check = await prefs.clear().then((bool success) {
        return success;
      });
    if(check == true){
      check = await prefs.setString('usuario', jsonEncode(usuario.toJson())).then((bool success){
        return success;
      });
    }
    return check;
  } 

}