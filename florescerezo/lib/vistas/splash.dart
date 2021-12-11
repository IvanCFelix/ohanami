import 'dart:async';

import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/lista.dart';
import 'package:florescerezo/vistas/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key,/* this.usuario */}) : super(key: key);
  //final usuario;

  @override
  State<Splash> createState() => _SplashState( /*usuario: usuario */);
}

class _SplashState extends State<Splash> {
  /*Usuario usuario;
  */
  bool check = false;
  //_SplashState({required this.usuario});
  @override
  void initState() {
    validacion().whenComplete(() async {
      Timer(Duration(),
      (){
        check == false ? 
      Navigator.push( context, MaterialPageRoute( builder: (context) =>VistaLogin())) :
      Navigator.push( context, MaterialPageRoute(builder: (context) =>VistaListaPartidas()));
      });
    });
    super.initState();
  }

  Future validacion() async{
    RepositorioMongo mongo = RepositorioMongo();
    RepositorioLocal local = RepositorioLocal();
    Usuario usuario = await local.recuperarUsuario();
    if (usuario == null) {
      Navigator.push( context, MaterialPageRoute( builder: (context) => VistaLogin()));
    }
    Usuario u = await mongo.recuperarUsuario(usuario: usuario);
    local.registrarUsuario(usuario: usuario);

    setState(() {
      check = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
              )
            ],
          ),
        ),
      ),
    );
  }
}