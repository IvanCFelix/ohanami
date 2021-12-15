import 'package:flutter/material.dart';
import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';

import 'package:partida/partida.dart';
import 'package:provider/src/provider.dart';
class VistaRonda2 extends StatefulWidget {
  const VistaRonda2({ Key? key, required this.partida}) : super(key: key);
  final Partida partida; 

  @override
  State<VistaRonda2> createState() => _VistaRonda2State(partida);
}

class _VistaRonda2State extends State<VistaRonda2> {
List<TextEditingController> _cartasAzules = [];
  List<TextEditingController> _cartasVerdes = [];
  List<TextEditingController> _cartasRosas = [];
  List<TextEditingController> _cartasGrises = [];
  Partida partida;

  _VistaRonda2State(this.partida);
    void validarNumeroDeCartas(index){
      try {
        List<CRonda2> lista = [];
        for (var i = 0; i < index; i++) {
          print("jugador " + (i + 1).toString());
          int azules =int.parse(_cartasAzules[i].text);
          int verdes =int.parse(_cartasVerdes[i].text);
          CRonda2 cr1 = CRonda2(
            jugador: partida.jugadores.elementAt(i), 
            cuantasAzules: azules,
            cuantasVerdes: verdes, 
          );
          lista.add(cr1);
        }
        partida.cartasRonda2(lista);
        context.read<OhanamiBloc>().add(SiguienteRonda3(partida: partida));
      } on Exception catch (e){
        _Mensaje(e.toString());
      }
    }
  void _Mensaje(String mensaje){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Cartas Ronda 2"),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 80),
                itemCount: partida.jugadores.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index == partida.jugadores.length
                      ? Container(
                          child: Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    validarNumeroDeCartas(index);
                                  },
                                  child: Text("data"))),
                        )
                      : Padding(
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
                                      Text(partida.jugadores
                                          .elementAt(index)
                                          .nombre
                                          .toString()),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Text("Cartas"),
                                ),
                                Container(
                                  height: 80.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _campoDeTexto(_cartasAzules, Colors.blue, index, "Azules",),
                                      _campoDeTexto(_cartasVerdes, Colors.green, index, "Verdes"),
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

_campoDeTexto(_var, _color, index, cartas) {
  _var.add(TextEditingController());
  return Container(
    color: _color,
    height: 80,
    width: 80,
    child: TextFormField(
      onChanged: (_) {},
      keyboardType: TextInputType.number,
      controller: _var[index],
      maxLength: 2,
      decoration: InputDecoration(
        labelText: cartas,
      ),
    ),
  );
} 