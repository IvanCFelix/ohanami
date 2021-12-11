import 'dart:async';

import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/cuerpo.dart';
import 'package:florescerezo/vistas/lista.dart';
import 'package:flutter/material.dart';
class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
 late Usuario usuario;  
 RepositorioMongo mongo = RepositorioMongo();
void initState(){
  validacion().whenComplete(() async{
    Timer(Duration(seconds: 2), ()=> (usuario == null ? VistaListaPartidas() : VistaLogin()));

  });

}

Future validacion() async{
  bool check = await mongo.verificarInicioSesion(usuario: usuario);
      print(check);
      if (check == true) {
        
        
      }
}
class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(Icons.local_activity
              ),
              radius: 50.0,
            ),
            CircularProgressIndicator(
            )
          ],
        ),
      ),
    );
  }
}