import 'package:db_paquete/db_paquete.dart';
import 'package:florescerezo/db/db_local.dart';
import 'package:florescerezo/vistas/lista.dart';
import 'package:florescerezo/vistas/splash.dart';
import 'package:flutter/material.dart';
class VistaLogin extends StatelessWidget {
  const VistaLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    TextEditingController correo = TextEditingController();
    TextEditingController clave = TextEditingController();
    RepositorioLocal local = RepositorioLocal();
    
    void gurdarUsuario() async{
      Usuario usuario = Usuario(nombre: correo.text.toString() ,clave: clave.text.toString() , partidas: [],telefono: 0);
      local.registrarUsuario(usuario: usuario);
      print(usuario.toString());
    }
    void sinconexion() async{
      Usuario usuario = Usuario(nombre: correo.text.toString() ,clave: clave.text.toString() , partidas: [],telefono: 0);
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
                      controller: correo,
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
                      
                      gurdarUsuario();
                      Navigator.push( context, MaterialPageRoute(builder: (context) => Splash()));
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