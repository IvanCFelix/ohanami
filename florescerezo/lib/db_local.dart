import 'dart:convert';
import 'package:db_paquete/db_paquete.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RepositorioLocal{
  
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


}