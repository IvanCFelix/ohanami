import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/estilos.dart';
import 'package:florescerezo/vistas/lista_partida.dart';
import 'package:florescerezo/vistas/vista_cargando.dart';
import 'package:flutter/material.dart';
class VistaLogin extends StatelessWidget {
VistaLogin({ Key? key }) : super(key: key);

    TextEditingController nombre = TextEditingController();
    TextEditingController clave = TextEditingController();
    RepositorioLocal local = RepositorioLocal();
    RepositorioMongo mongo = RepositorioMongo();
    
    void IniciarSesion(context) async{

      bool check = await mongo.inicializar();
      
      if (check == true) {
        Usuario usuario = Usuario(nombre: nombre.text.toString() ,clave: clave.text.toString() , partidas: [], correo: "");
        bool sesionIniciada = await mongo.verificarInicioSesion(usuario: usuario);
        if (sesionIniciada == true) {
        Usuario usuarioMongo = await  mongo.recuperarUsuario(usuario: usuario);
        local.registrarUsuario(usuario: usuarioMongo);
        print(usuarioMongo.toString());
        Navigator.push( context, MaterialPageRoute(builder: (context) => VistaListaPartidas()));
        }
        else
        {
        print("Datos de inicio de sesion incorrectos");
        }
      }
      else
      {
        print("No hay conexion");

      }
    }

    void sinconexion() async{
      Usuario usuario =Usuario(nombre: "", correo: "", clave: "", partidas: []);
      local.registrarUsuario(usuario: usuario);
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: secondaryLightColor,
        appBar: AppBar(
          backgroundColor: primaryDarkColor,
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network('http://mercurio.com.es/images/cabecero_ohanami_2018.jpg?crc=391650972',
                    height: 100.0,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                        child: TextField(
                          controller: nombre,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.account_circle),
                            hintText: 'ejemplo@correo.com',
                            labelText: 'Correo electronico',
                          ),
                          onChanged:(vaule){
          
                          },
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Container(
                        child: TextField(
                          controller: clave,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            icon: Icon(Icons.password),
                            hintText: 'Contraseña',
                            labelText: 'Contraseña',
                          ),
                          onChanged:(vaule){
          
                          },
                        ),
                      ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:ElevatedButton(
                        onPressed: () async{
                          IniciarSesion(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Iniciar Sesion',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                        style:ElevatedButton.styleFrom(
                          elevation: 10.0, 
                          textStyle: const TextStyle(
                            fontSize: 20,
                            
                            )
                            ),
                        )
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                        onPressed: () async {
                          sinconexion();
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => VistaListaPartidas()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Sin conexion',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                        style:ElevatedButton.styleFrom(
                          elevation: 10.0, 
                          textStyle: const TextStyle(
                            fontSize: 20,
                            
                      )
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
    );
  }
}