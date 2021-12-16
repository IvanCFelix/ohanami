import 'dart:math';
import 'package:florescerezo/estilos.dart';
import 'package:florescerezo/vistas/bloc.dart';
import 'package:flutter/material.dart';
import 'package:partida/partida.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NuevaPartida extends StatefulWidget {
  const NuevaPartida({Key? key}) : super(key: key);

  @override
  _NuevaPartidaState createState() => _NuevaPartidaState();
}

class _NuevaPartidaState extends State<NuevaPartida> {
  late String _resultado;
  late int _contador;
  late bool aumentarNJugador, eliminarJugador, comenzar;
  List<IconData> iconos = [];
  List<IconData> iconosJugadores = [];

  late final List<TextEditingController> _lista =
  List.generate(4, (i) => TextEditingController());

  @override
  void initState() {
    super.initState();
    comenzar = false;
    eliminarJugador = false;
    _resultado = '';
    _contador = 2;
    llenarLitaIconos();
    iconosParaJugadores();
  }
  
  llenarLitaIconos(){
      iconos.add(FontAwesomeIcons.gamepad);
      iconos.add(FontAwesomeIcons.chessRook);
      iconos.add(FontAwesomeIcons.dice);
      iconos.add( FontAwesomeIcons.microchip);
      iconos.add(FontAwesomeIcons.code); 
      iconos.add(FontAwesomeIcons.bug);
      iconos.add(FontAwesomeIcons.heartbeat);
      iconos.add(FontAwesomeIcons.chessPawn);
      iconos.add( FontAwesomeIcons.featherAlt);
      iconos.add(FontAwesomeIcons.dragon); 
      iconos.add(FontAwesomeIcons.hotdog);
      iconos.add( FontAwesomeIcons.radiationAlt);
      iconos.add(FontAwesomeIcons.cat); 
      iconos.add(FontAwesomeIcons.dog);
      iconos.add(FontAwesomeIcons.robot); 
      iconos.add(FontAwesomeIcons.iceCream);
      iconos.add(FontAwesomeIcons.cookie); 
      iconos.add(FontAwesomeIcons.truckMonster); 
      iconos.add(FontAwesomeIcons.fire);
      iconos.add(FontAwesomeIcons.bacon); 
  }

  iconosParaJugadores(){
    do {
    var aleatorio = new Random();
    int numero = aleatorio.nextInt(19);
    var contenido = iconosJugadores.contains(iconos[numero]);
    if(contenido == false){
      iconosJugadores.add(iconos[numero]);
    }
    } while (iconosJugadores.length<=4);

  }

  void checar(){
    bool check = true;  
    for (var i = 0; i < _contador; i++) {
      print(_lista[i].text.isEmpty);
        if (_lista[i].text.isEmpty){
          check = false;
        } 
    }
    setState(() {
      comenzar = check;
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Nueva Partida"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text("Ingrese los jugadores"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _contador,
                itemBuilder: (context, index) {
      
                  return _campoDeTexto(index, iconosJugadores[index]); 
                }
              ),
      
              const SizedBox(height: 15),
              Row(
                children: [
                  _contador == 4 ? const 
                  ElevatedButton(
                    onPressed: null,
                    child: Text("Añadir Jugador",
                      style: TextStyle(
                      ),
                    ),
                  )
                  : 
                  ElevatedButton(
                    onPressed: () => {
                      if (_contador < 4){
                        setState(() {
                          _contador++;
                          comenzar = false;
                        }
                        ),
                      }
                    },
                    child: const Text("Añadir Jugador",
                    style: TextStyle(
                      color: secondaryTextColor
                    ),
      
                    ),
                  ),
                  const SizedBox(width: 5),
                  _contador == 2 ? const 
                  
                  ElevatedButton(
                    onPressed: null,
                    child: Text("Eliminar Jugador"),
                  )
                  : 
                  ElevatedButton(
                    onPressed: () => {
                      if (_contador > 2){
                        if (_contador >= 3){
                          _lista[_contador - 1].clear(),
                        },
                        setState(() {
                          _contador--;
                        }
                        ),
                        checar()
                      },
                    },
                    child: const Text("Eliminar Jugador",
                    style: TextStyle(
                      color: secondaryTextColor,
                    ),
                    
                    ),
                  ),
                  const SizedBox(width: 5),
                  (comenzar == false) ? const 
                 
                  ElevatedButton(
                    onPressed: null,
                    child: Text("Comenzar"),
                  )
                  : 
                  ElevatedButton(
                    onPressed: () {
                      Set<Jugador> jugadores = {};
                      for (var i = 0; i < _contador; i++) {
                        jugadores.add(Jugador(nombre: _lista[i].text));
                      }
                      Partida partida = Partida(jugadores: jugadores);
                      Navigator.push(context, MaterialPageRoute( builder: (context) => Blocvista(partida: partida, iconosJugadores: iconosJugadores, )));
                    },
      
                    child: const Text("Comenzar",
                    style: TextStyle(
                      color: secondaryTextColor
                    ),
                    ),
                  ),
                ],
              ),
      
            Text(_resultado),
            ],
          )
        ),
      ),
    );
  }

  _campoDeTexto(int index , icon) {
    int numero = index+1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Jugador $numero",
          suffixIcon: Icon(icon) 
        ),
        controller: _lista[index],
        onChanged: (_) {
          checar();
        }
      ),
    );
  }
}