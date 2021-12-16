import 'dart:async';

import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/main.dart';
import 'package:florescerezo/vistas/lista_partida.dart';
import 'package:flutter/material.dart';

class VistaRegistro extends StatefulWidget {
  const VistaRegistro({ Key? key,}) : super(key: key);
  @override
  State<VistaRegistro> createState() => _VistaRegistroState();
}

class _VistaRegistroState extends State<VistaRegistro> {
  bool check = false;
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController clave = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future validacion() async{
    RepositorioMongo mongo = RepositorioMongo();
    RepositorioLocal local = RepositorioLocal();
    local.eliminarUsuario();
    
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
    bool nombreUsuarioEnUso = await mongo.registradoUsuario(usuario:u);
    if (nombreUsuarioEnUso == true) {
      print("Este nombre de usuario ya esta registrado");
    }
    else
    {
      RepositorioLocal local = RepositorioLocal();
      bool usuarioLocalActualizado = await local.actualizarDatosUsuario(usuarioNuevo:u);
      if (usuarioLocalActualizado == true) {
        Usuario usuarioLocal= await  local.recuperarUsuario();
        print("Usuario actualizado en local");
        RepositorioMongo mongo=RepositorioMongo();

        bool usuarioRegistradoConExito= await mongo.registrarUsuario(usuario: usuarioLocal);
            usuarioRegistradoConExito == true ? print("usuario registrado en mongo") : print("hubo un error al registrar");
      Navigator.push( context, MaterialPageRoute(builder: (context) => VistaListaPartidas()));
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
        ),
      ),
    );
  }
}