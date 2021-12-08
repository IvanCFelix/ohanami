import 'dart:convert';

import 'package:flutter/material.dart';

class NuevaPartida extends StatefulWidget {
  const NuevaPartida({Key? key}) : super(key: key);

  @override
  _NuevaPartidaState createState() => _NuevaPartidaState();
}

class _NuevaPartidaState extends State<NuevaPartida> {
  late int _count;
  late String _result;
  late bool agregar, agregar2, eliminar, comenzar;

  late final List<TextEditingController> _controllers =
      List.generate(4, (i) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _count = 2;
    _result = '';
    agregar = false;
    agregar2 = false;
    eliminar = false;
    comenzar = false;
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
                  itemCount: _count,
                  itemBuilder: (context, index) {
                    return _row(index);
                  }),
              const SizedBox(height: 15),
              Row(
                children: [
                  _count == 4
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text("Añadir Jugador"),
                        )
                      : ElevatedButton(
                          onPressed: () => {
                            if (_count < 4)
                              {
                                setState(() {
                                  _count++;
                                }),
                              }
                          },
                          child: const Text("Añadir Jugador"),
                        ),
                  const SizedBox(width: 5),
                  _count == 2
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text("Eliminar Jugador"),
                        )
                      : ElevatedButton(
                          onPressed: () => {
                            if (_count > 2)
                              {
                                if (_count >= 3)
                                  {
                                    _controllers[_count - 1].clear(),
                                  },
                                setState(() {
                                  _count--;
                                  print(_count);
                                }),
                              }
                          },
                          child: const Text("Eliminar Jugador"),
                        ),
                  const SizedBox(width: 5),
                  (agregar == false)
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text("Comenzar"),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            for (int i = 0; _count + 0 > i; i++) {
                              String val = _controllers[i].text.toString();

                              Map<String, dynamic> json = {
                                'id': i,
                                'nombre': _controllers[i].text
                              };
                              // print("jugador enviado:" + json.toString());
                              // print(val);
                              // print(json);
                            }
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

  _row(int key) {
    return Row(
      children: [
        Text('Jugador ' + (key + 1).toString() + ':'),
        const SizedBox(width: 30),
        Expanded(
            child: TextFormField(
                controller: _controllers[key],
                onChanged: (_) {
                  // for (int i = 0; _count - 1 >= i; i++) {
                  //   Map<String, dynamic> json = {'id': i, 'nombre': _controllers[i].text};
                  // }
                })),
      ],
    );
  }
}