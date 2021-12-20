import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/bloc_ohanami/constantes.dart';
import 'package:florescerezo/db/db_helper.dart';
import 'package:florescerezo/estilos.dart';
import 'package:florescerezo/widget_screens/lista_partida.dart';
import 'package:florescerezo/widget_screens/vista_registro.dart';
import 'package:florescerezo/widget_screens/loading_widget.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Datos de inicio de sesion incorrectos")));
        }
      }
      else
      {
        print("No hay conexion");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No hay conexion")));

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
        backgroundColor: Colors.white,
       
        body: SingleChildScrollView(
            child: Column(
              children: [
                  Container(
                    padding: const EdgeInsets.only(top: 
                    80),
                    child: Image.asset(ohanami_logo,
                    height: 100.0,
                    ),
                  ),
                  Card(
                  margin: EdgeInsets.all(20),  
                  elevation: 11,
                  
                  child: Column(children: [
                   Container(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                          controller: nombre,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Nombre de usuario',
                            iconColor: Colors.pink.shade200,
                            fillColor: Colors.pink.shade200
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
                            prefixIcon: Icon(Icons.lock),
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Iniciando conexion")));
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
                  child: TextButton(
                        onPressed: () async {
                          sinconexion();
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => VistaRegistro()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Registrarse',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                          ),
                          ),
                        ),
                        style:TextButton.styleFrom(
                          
                          textStyle: const TextStyle(
                            fontSize: 20,
                            
                      )
                    ),
                  )
                ),],
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                        onPressed: () async {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bienvenido")));
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