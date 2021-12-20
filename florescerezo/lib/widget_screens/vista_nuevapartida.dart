import 'dart:math';
import 'package:florescerezo/estilos.dart';
import 'package:florescerezo/widget_screens/vista_bloc.dart';
import 'package:flutter/material.dart';
import 'package:partida/partida.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Vista_NuevaPartida extends StatefulWidget {
  const Vista_NuevaPartida({Key? key}) : super(key: key);
  @override
  _Vista_NuevaPartidaState createState() => _Vista_NuevaPartidaState();
}

class _Vista_NuevaPartidaState extends State<Vista_NuevaPartida> {
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
  
    _campoDeTexto(int index , icon) {
    int numero = index+1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLength: 10,
                decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
          hintText: "Jugador $numero",
          prefixIcon: Icon(Icons.person),
         hintStyle: TextStyle(color: Colors.grey[400])
          
        ),
        controller: _lista[index],
        onChanged: (_) {
          validacionBotones();
        }
      ),
    );
  }

  llenarLitaIconos(){
      iconos.add(FontAwesomeIcons.gamepad);
      iconos.add(FontAwesomeIcons.chessRook);
      iconos.add(FontAwesomeIcons.dice);
      iconos.add( FontAwesomeIcons.microchip);
      iconos.add(FontAwesomeIcons.code); 
      iconos.add(FontAwesomeIcons.bug);
      iconos.add(FontAwesomeIcons.heart);
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

  void validacionBotones(){
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
        title: const Text("Nueva Partida",style: TextStyle(color: Colors.black),),
       leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Navigator.of(context).pop(),
  ), 
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text("Ingrese los jugadores",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _contador,
                itemBuilder: (context, index) {
                  return _campoDeTexto(index, iconosJugadores[index]); 
                }
              ),
              const SizedBox(height: 15),
              Column(
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
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink[100])),
                    child: const Text("Añadir Jugador",
                    style: TextStyle(
                      color: primaryTextColor
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
                        validacionBotones()
                      },
                    },                    
                     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: const Text("Eliminar Jugador",
                    style: TextStyle(
                      color: Colors.white,
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
                      Navigator.push(context, MaterialPageRoute( builder: (context) => Vista_Bloc(partida: partida, iconosJugadores: iconosJugadores)));
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
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
}