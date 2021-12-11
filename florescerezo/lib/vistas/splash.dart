import 'dart:async';

import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/lista.dart';
import 'package:florescerezo/vistas/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key,}) : super(key: key);


  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool check = false;
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
    check = await local.registradoUsuario();
    print(check);

    if(check == true){
    Usuario usuario = await local.recuperarUsuario();
    if (usuario == null) {
      Navigator.push( context, MaterialPageRoute( builder: (context) => VistaLogin()));
    }
    check = await mongo.registradoUsuario(usuario: usuario);
    if (check == true) {
    Usuario u = await mongo.recuperarUsuario(usuario: usuario);
    check = await local.registrarUsuario(usuario: u);
    }
          setState(() {
        check = true;
      });
  }

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