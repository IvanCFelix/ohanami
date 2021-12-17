import 'dart:convert';
import 'package:db_paquete/db_paquete.dart';
import 'package:partida/src/partida.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RepositorioLocal{
  
  Future<bool> eliminarUsuario() async {
    late bool consultar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    consultar = await prefs.clear().then((bool success) {
        return success;
      });
    return consultar;
  }

  Future<bool> registradoUsuario() async {
    late bool consultar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    if (respuesta == null){
     return consultar = false;
    }
    return consultar = true;
  }

  Future<bool> registrarPartida({required Partida partida}) async {
    late bool consultar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    var respuestaJson = jsonDecode(respuesta!);
    Usuario usuario = Usuario.fromJson(respuestaJson);
    usuario.partidas.add(partida);
    consultar = await registrarUsuario(usuario: usuario);
    return consultar;
  }

  Future<bool> registrarUsuario({required Usuario usuario}) async {
    late bool consultar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    consultar = await prefs.setString('usuario', jsonEncode(usuario.toJson())).then((bool logro) {
        return logro;
      });
    return consultar;
  }
  
  Future<Usuario> recuperarUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    var usuarioJson = jsonDecode(respuesta!);
    Usuario usuario = Usuario.fromJson(usuarioJson);
    return usuario;
  }
    
  Future<bool> reescribirUsuario({required Usuario usuario})async{
    bool consultar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    consultar = await prefs.clear().then((bool logro) {
        return logro;
      });
    if(consultar == true){
      consultar = await prefs.setString('usuario', jsonEncode(usuario.toJson())).then((bool logro){
        return logro;
      });
    }
    return consultar;
  }

  Future<bool> actualizarDatosUsuario({required Usuario usuarioNuevo}) async{
    late bool consultar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    var respuestaJson = jsonDecode(respuesta!);
    Usuario usuarioViejo = Usuario.fromJson(respuestaJson);
    usuarioViejo.nombre = usuarioNuevo.nombre;
    usuarioViejo.clave = usuarioNuevo.clave;
    usuarioViejo.correo = usuarioNuevo.correo;
    consultar = await  reescribirUsuario(usuario: usuarioViejo);
    return consultar;
  }

  Future<bool> eliminarPartida({required int indice}) async{
    late bool consultar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var respuesta =  prefs.getString('usuario');
    var respuestaJson = jsonDecode(respuesta!);
    Usuario usuarioViejo = Usuario.fromJson(respuestaJson);
    usuarioViejo.partidas.removeAt(indice);
    consultar = await  reescribirUsuario(usuario: usuarioViejo);
    return consultar;
  } 
}