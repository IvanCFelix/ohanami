import 'dart:async';

import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/bloc_ohanami/constantes.dart';
import 'package:florescerezo/db/db_helper.dart';
import 'package:florescerezo/estilos.dart';
import 'package:florescerezo/vistas/lista_partida.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  void validarLocal() async{
    RepositorioMongo mongo = RepositorioMongo();
    RepositorioLocal local = RepositorioLocal();
    bool consultar = await local.registradoUsuario();
    if (consultar == true) {
      validarRegistro();
    }
    if (consultar == false) {
      Usuario nuevoUsuario = Usuario(nombre: nombre.text, correo: correo.text, clave: clave.text, partidas: []);
      bool usuariomongo = await mongo.registradoUsuario(usuario: nuevoUsuario);
      
      if (usuariomongo) {  
      bool consultar2 = await local.registrarUsuario(usuario: nuevoUsuario);
      
      if (consultar2 == true) {
        bool usuarioRegistradoConExito= await mongo.registrarUsuario(usuario: nuevoUsuario);
      }

      }
    }
  }

  void validarRegistro() async{

    RepositorioMongo mongo = RepositorioMongo();
    Usuario nuevoUsuario = Usuario(nombre: nombre.text, correo: correo.text, clave: clave.text, partidas: []);
    bool nombreUsuarioEnUso = await mongo.registradoUsuario(usuario:nuevoUsuario);
    if (nombreUsuarioEnUso == true) {
      print("Este nombre de usuario ya esta registrado");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Este nombre de usuario ya esta registrado")));  

    }
    if(nombreUsuarioEnUso == false)
    {
      RepositorioLocal local = RepositorioLocal();
      bool usuarioLocalActualizado = await local.actualizarDatosUsuario(usuarioNuevo:nuevoUsuario);
      if (usuarioLocalActualizado == true) {
        Usuario usuarioLocal= await  local.recuperarUsuario();
        print("Usuario actualizado en local");
        RepositorioMongo mongo=RepositorioMongo();

        bool usuarioRegistradoConExito= await mongo.registrarUsuario(usuario: usuarioLocal);
            if (usuarioRegistradoConExito == true) {
            print("usuario registrado en mongo");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuario registrado en mongo")));  
            }
            if (usuarioRegistradoConExito == false) {
            print("hubo un error al registrar");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al registrar")));  
              
            }
      Navigator.push( context, MaterialPageRoute(builder: (context) => VistaListaPartidas()));
      }
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
               [
                Image.asset(logo_mrecurio),

                 TextFormField(
                    keyboardType: TextInputType.name,
                   controller: nombre,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    icon: Icon(FontAwesomeIcons.user),
                    labelStyle: TextStyle(
                      color: primaryColor,
                    ),
                    helperText: 'Nombre de usuario',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:primaryColor),
                    ),
                  ),
                ),
                TextFormField(
                   keyboardType: TextInputType.emailAddress,
                   controller: correo,
                  maxLength: 20,
                  decoration: const InputDecoration(

                    icon: Icon(FontAwesomeIcons.mailBulk),
                    labelStyle: TextStyle(
                      color: primaryColor,
                    ),
                    helperText: 'Correo',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                   keyboardType: TextInputType.visiblePassword,
                   controller: clave,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    labelStyle: TextStyle(
                      color:primaryColor,
                    ),
                    helperText: 'Contraseña',

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    print("empezo");
                    validarLocal();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Iniciando conexion")));
                  }, 
                  child:const Text("Registrarse",
                  style: TextStyle(
                    color: secondaryTextColor
                  ),
                  ),
                  )
              ],
            ),
          ),
        ),
      );
  }
}