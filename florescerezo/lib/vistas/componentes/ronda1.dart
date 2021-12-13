import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';
import 'package:flutter/material.dart';
import 'package:partida/partida.dart';
import 'package:provider/src/provider.dart';

class VistaRonda1 extends StatelessWidget {
  VistaRonda1({ Key? key, required this.partida}) : super(key: key);
  final Partida partida; 

  List<String> camposTexto = [];

  final Map<String, TextEditingController> _jugador = Map();
  TextEditingController _cA = TextEditingController() ;
  TextEditingController _cV = TextEditingController();
  TextEditingController _cR = TextEditingController();
  TextEditingController _cG = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Cartas Ronda 1"),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 80),
              itemCount: partida.jugadores.length+1,
              itemBuilder: (BuildContext context, int index) {
                return index == partida.jugadores.length ?
                Container(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: (){
                        for (var i = 0; i < 4; i++) {
                         print(_cA.text.toString());
                          
                        }
                      }, 
                      child: Text("data")
                      ) 
                    ),
                ):
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.tealAccent,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline),
                              Text(partida.jugadores.elementAt(index).nombre.toString()),
                            ],
                          ),
                        ),
                        Container(
                          child: Text("Cartas"),
                        ),
                        Container(
                          height: 80.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _campoDeTexto(0, _cA, Colors.blue, _jugador ),
                              _campoDeTexto(1, _cV, Colors.green,_jugador),
                              _campoDeTexto(2, _cR, Colors.pink, _jugador),
                              _campoDeTexto(3, _cG, Colors.grey, _jugador),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                
              }    
            ),
          ),
        ],
      ),
    );
  }
}
  _campoDeTexto(int key , _control, _color, map) {
    return Container(
      color: _color,
      height: 80,
      width: 80,
      child: TextFormField(
        onChanged: (_){
        },
        keyboardType: TextInputType.number,
        controller:_control,
        maxLength: 2,
      ),
    );
  }