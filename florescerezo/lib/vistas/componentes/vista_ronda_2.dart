import 'package:florescerezo/estilos.dart';
import 'package:flutter/material.dart';
import 'package:florescerezo/bloc_ohanami/bloc_ohanami.dart';
import 'package:florescerezo/bloc_ohanami/eventos.dart';

import 'package:partida/partida.dart';
import 'package:provider/src/provider.dart';
class VistaRonda2 extends StatefulWidget {
  const VistaRonda2({ Key? key, required this.partida, required this.iconosJugadores}) : super(key: key);
  final Partida partida; 
  final List<IconData> iconosJugadores;

  @override
  State<VistaRonda2> createState() => _VistaRonda2State(partida, iconosJugadores);
}

_campoDeTexto(_var, _color, index, cartas) {
  _var.add(TextEditingController());
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 80,
      width: 80,
      child: TextFormField(
        onChanged: (_){},
        controller: _var[index],
       maxLength: 2,
       decoration: InputDecoration(
         counterText: "",
         focusColor: _color,
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(color: _color
           )
          ),
         labelText:cartas,
         labelStyle: TextStyle(
         color: _color,
           fontSize: 20
         ),
         border: OutlineInputBorder(),
         enabledBorder: UnderlineInputBorder(
        
         borderSide: BorderSide(color: _color),
         ),

       ),
      ),
    ),
  );
} 

class _VistaRonda2State extends State<VistaRonda2> {
List<TextEditingController> _cartasAzules = [];
  List<TextEditingController> _cartasVerdes = [];
  List<TextEditingController> _cartasRosas = [];
  List<TextEditingController> _cartasGrises = [];
  
  Partida partida;
  List<IconData> iconosJugadores;

  _VistaRonda2State(this.partida, this.iconosJugadores);
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
        context.read<OhanamiBloc>().add(SiguienteRonda3(partida: partida, iconosJugadores: iconosJugadores));
      } on Exception catch (e){
        _MensajeScaffol(e.toString());
      }
    }
  void _MensajeScaffol(String mensaje){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:secondaryLightColor, //secondaryTextColor,
      appBar: AppBar(
        backgroundColor: primaryColor,//primaryColor,
        title: Text("Ronda 2",
        style: TextStyle(
          color: Colors.white
        ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                                child: Text("Siguiente Ronda"))),
                          )
                  :
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(iconosJugadores[index]),
                            title:Text(partida.jugadores.elementAt(index).nombre.toString()),
                            subtitle: Text('Asignacion de las cartas',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Row(
                            children: [
                          _campoDeTexto(_cartasAzules, Colors.blue, index, "Azules"),
                          _campoDeTexto(_cartasVerdes, Colors.green, index, "Verdes"),
                            ],
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
      ),
    );
  }
}
