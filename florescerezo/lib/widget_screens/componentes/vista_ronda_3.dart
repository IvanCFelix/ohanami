import 'package:florescerezo/db/db_helper.dart';
import 'package:florescerezo/estilos.dart';
import 'package:flutter/material.dart';
import 'package:partida/partida.dart';

import '../display_stats.dart';

class VistaRonda3 extends StatefulWidget {
  const VistaRonda3({ Key? key, required this.partida ,required this.iconosJugadores}) : super(key: key);
  final Partida partida;
  final List<IconData> iconosJugadores;

  @override
  State<VistaRonda3> createState() => _VistaRonda3State(partida, iconosJugadores);
}

class _VistaRonda3State extends State<VistaRonda3> {
  List<TextEditingController> _cartasAzules = [];
  List<TextEditingController> _cartasVerdes = [];
  List<TextEditingController> _cartasRosas = [];
  List<TextEditingController> _cartasGrises = [];
  Partida partida;
  List<IconData> iconosJugadores;

  _VistaRonda3State(this.partida, this.iconosJugadores);

    Future<void> validarNumeroDeCartas(index) async {
  try {
      List<CRonda3> lista = [];
  for (var i = 0; i < index; i++) {
    print("jugador " + (i + 1).toString());
    int azules =int.parse(_cartasAzules[i].text);
    int verdes =int.parse(_cartasVerdes[i].text);
    int rosas =int.parse(_cartasRosas[i].text);
    int grises =int.parse(_cartasGrises[i].text);
    CRonda3 cr1 = CRonda3(
      jugador: partida.jugadores.elementAt(i), 
      cuantasAzules: azules,
      cuantasVerdes: verdes,
      cuantasRosas: rosas,
      cuantasNegras: grises, 
      );
    lista.add(cr1);
  }
  List<PuntuacionJugador> j;
    partida.cartasRonda3(lista);
    bool check = await actualizar(partida: partida);
    if (check == true) {
    Navigator.push(context, MaterialPageRoute( builder: (context) => DetallePartida(partida: partida,)));
    }
  } on Exception catch (e){
    _MensajeScaffol(e.toString());
  }
}

void _MensajeScaffol(String mensaje){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<bool> actualizar({required Partida partida})async{
    bool check = false;
    RepositorioLocal local = RepositorioLocal();
    check = await local.registrarPartida(partida: partida);
    return check;
  }

_campoDeTexto(_var, _color, index, cartas) {
  _var.add(TextEditingController());
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 80,
      width: MediaQuery.of(context).size.width*0.18,
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Ronda 3",
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
                                            elevation: 6,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                           
                            title:Text(partida.jugadores.elementAt(index).nombre.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            subtitle: Text('Asignacion de las cartas',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Row(
                                                        children: [
                          _campoDeTexto(_cartasAzules, Colors.blue, index, "Azules"),
                          _campoDeTexto(_cartasVerdes, Colors.green, index, "Verdes"),
                          _campoDeTexto(_cartasRosas, Colors.pink, index, "Rosas"),
                          _campoDeTexto(_cartasGrises, Colors.black, index, "Negras")
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