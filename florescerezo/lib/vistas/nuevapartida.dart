import 'package:flutter/material.dart';
class NuevaPartida extends StatefulWidget {
  const NuevaPartida({Key? key}) : super(key: key);

  @override
  _NuevaPartidaState createState() => _NuevaPartidaState();
}

class _NuevaPartidaState extends State<NuevaPartida> {
  late bool agregar, eliminar, comenzar;
  late int _contador;

  late String _result;

  late final List<TextEditingController> _lista =
  List.generate(4, (i) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _contador = 2;
    _result = '';
    eliminar = false;
    comenzar = false;
  }
  void checar(){
    bool check = true;  
    for (var i = 0; i < _contador; i++) {
      print(_lista[i].text.isEmpty);
        if (_lista[i].text.isEmpty){
          check = false;
        } 
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar partida"),
      ),
      body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _contador,
                  itemBuilder: (context, index) {
                    return _campoDeTexto(index);
                  }),
              const SizedBox(height: 15),
              Row(
                children: [
                  _contador == 4
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text("Añadir Jugador"),
                        )
                      : ElevatedButton(
                          onPressed: () => {
                            if (_contador < 4)
                              {
                                setState(() {
                                  _contador++;
                                  comenzar = false;
                                }),
                              }
                          },
                          child: const Text("Añadir Jugador"),
                        ),
                  const SizedBox(width: 5),
                  _contador == 2
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text("Eliminar Jugador"),
                        )
                      : ElevatedButton(
                          onPressed: () => {
                            if (_contador > 2)
                              {
                                if (_contador >= 3)
                                  {
                                    _lista[_contador - 1].clear(),
                                  },
                                setState(() {
                                  _contador--;

                                }),
                                  checar()
                              },
                          },
                          child: const Text("Eliminar Jugador"),
                        ),
                  const SizedBox(width: 5),
                  (comenzar == false)
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text("Comenzar"),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            
                            
                          },
                          child: const Text("Comenzar"),
                        ),
                ],
              ),
              Text(_result),
            ],
          )),
    );
  }

  _campoDeTexto(int key) {
    return Row(
      children: [
        Text('Jugador ' + (key + 1).toString() + ':'),
        const SizedBox(width: 30),
        Expanded(
          child: TextFormField(
            controller: _lista[key],
            onChanged: (_) {
              checar();
            }
          )
        ),
      ],
    );
  }
}