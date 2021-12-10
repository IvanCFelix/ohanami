import 'package:florescerezo/vistas/lista.dart';
import 'package:flutter/material.dart';
class VistaLogin extends StatelessWidget {
  const VistaLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network('https://cdn-icons-png.flaticon.com/512/678/678890.png',
              height: 300.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return  Container(
                    child: TextField(
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
                    onPressed: (){
                      
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
          ],
        ),
      ),
    );
  }
}