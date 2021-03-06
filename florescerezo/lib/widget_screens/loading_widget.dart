import 'dart:async';

import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_helper.dart';
import 'package:florescerezo/widget_screens/lista_partida.dart';
import 'package:florescerezo/widget_screens/vista_login.dart';
import 'package:flutter/material.dart';


class LoadingWidget extends StatefulWidget {
  const LoadingWidget({ Key? key,}) : super(key: key);


  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  bool check = false;
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController clave = TextEditingController();
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
    //local.eliminarUsuario();
    bool mongoconsultar = await mongo.inicializar();
    bool checkv = await local.registradoUsuario();

    if (mongoconsultar == true && checkv == true) {
      Usuario usuario = await local.recuperarUsuario();
      setState(() {
        check = true;
      });
    }
    if (mongoconsultar == false && checkv == true) {
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