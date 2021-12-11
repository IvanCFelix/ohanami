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
      Navigator.push( context, MaterialPageRoute( builder: (context) => VistaLogin())) :
      Navigator.push( context, MaterialPageRoute(builder: (context) => VistaListaPartidas()));
      });
    });
    super.initState();
  }

  Future validacion() async{
    RepositorioMongo mongo = RepositorioMongo();
    RepositorioLocal local = RepositorioLocal();
    bool mongocheck = await mongo.inicializar();
    bool checkv = await local.registradoUsuario();

    if (mongocheck == true && checkv == true) {
      Usuario usuario = await local.recuperarUsuario();
      checkv = await mongo.registradoUsuario(usuario: usuario);
      if (checkv == true) {
        Usuario u = await mongo.recuperarUsuario(usuario: usuario);
        checkv = await local.registrarUsuario(usuario: u);
        setState(() {
          check = checkv;
        });
      }
      setState(() {
        check = true;
      });
    }
    if (mongocheck == false && checkv == true) {
      setState(() {
        check = checkv;
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