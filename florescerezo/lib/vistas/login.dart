import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/lista_partida.dart';
import 'package:florescerezo/vistas/splash.dart';
import 'package:flutter/material.dart';
class VistaLogin extends StatelessWidget {
  const VistaLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    TextEditingController nombre = TextEditingController();
    TextEditingController clave = TextEditingController();
    RepositorioLocal local = RepositorioLocal();
    RepositorioMongo mongo = RepositorioMongo();
    
    void IniciarSesion() async{

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
//gurdarUsuario
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network('https://cdn-icons-png.flaticon.com/512/678/678890.png',
                height: 200.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return  Container(
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
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return  Container(
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
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return ElevatedButton(
                    onPressed: () async{
                      IniciarSesion();
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Iniciar Sesion',
                      style: TextStyle(
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
                    );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return ElevatedButton(
                    onPressed: () async {
                      sinconexion();
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VistaListaPartidas()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Sin conexion',
                      style: TextStyle(
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
                    );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}