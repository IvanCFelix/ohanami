import 'dart:async';

import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/lista_partida.dart';
import 'package:florescerezo/vistas/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key,}) : super(key: key);


  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool check = false;
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController clave = TextEditingController();
  @override
  void initState() {
    /*
    validacion().whenComplete(() async {
      Timer(Duration(),
      (){
        check == false ? 
      Navigator.push( context, MaterialPageRoute( builder: (context) => VistaLogin())) :
      Navigator.push( context, MaterialPageRoute(builder: (context) => VistaListaPartidas()));
      });
    });
    */
    super.initState();
  }

  Future validacion() async{
    RepositorioMongo mongo = RepositorioMongo();
    RepositorioLocal local = RepositorioLocal();
    //local.eliminarUsuario();
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

  void validarRegistro() async{
    RepositorioMongo mongo = RepositorioMongo();
    Usuario u = Usuario(nombre: nombre.text, correo: correo.text, clave: clave.text, partidas: []);
    bool check = await mongo.registradoUsuario(usuario:u);
    if (check == true) {
      print("Este nombre de usuario ya esta registrado");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Este nombre de usuario ya esta registrado"),
      ));
    }
    else
    {
      RepositorioLocal local = RepositorioLocal();
      bool check2 = await local.actualizarDatosUsuario(usuarioNuevo:u);
      if (check2 == true) {
        print("Usuario registrado");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Usuario registrado"),
      )); 
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
               [
                TextFormField(
                  controller: nombre,

                ),
                TextFormField(
                  controller: correo,
                  
                ),
                TextFormField( 
                  controller: clave,

                ),
                ElevatedButton(
                  onPressed: (){
                    print("empezo");
                    validarRegistro();

                  }, 
                  child:Text("Registrar"),
                  )
              ],
            ),
          ),
          /*
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
              )
            ],
          ),*/
        ),
      ),
    );
  }
}