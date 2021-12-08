import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/bloc_ohanami/estados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';

class Cuerpo extends StatelessWidget {
  const Cuerpo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<OhanamiBloc>().state;
    if(estado is Iniciando){
      return Container();  //VistaIniciandome();
    }
    if(estado is Login){
      return Container(); // VistaLogin();
    }
    return Container();
  }
}

class VistaIniciandome extends StatelessWidget {
  const VistaIniciandome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text("Se inicio"),
        ),
        ElevatedButton(
          onPressed: (){
            context.read<OhanamiBloc>().add(Entrar());
          },
          child: Text('Inicia Sesion'),
        ),
      ],
    );
  }
}

class VistaLogin extends StatelessWidget {
  const VistaLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Correo'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contrasena'),
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: (){
                      context.read<OhanamiBloc>().add(Entrar());
                    }, 
                    child: Text('Inicia Sesion'),
                    ),
                )
              ],
            )
            ),
        ),
      ],
    );
  }
}
