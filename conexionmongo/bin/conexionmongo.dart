import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

import 'jugador.dart';
void main(List<String> arguments)  async{
  print('Empezando');
  var db =  await  Db.create('mongodb+srv://a1000kr:1234@cluster0.bigji.mongodb.net/ejemplo?retryWrites=true&w=majority');
  
  await db.open();
  var col = db.collection('usuarios');
  Jugador martin = Jugador(nombre: 'Martin', cuantasVerdes: 2);
  //await col.insert(jsonDecode(martin.toJson()));
  
  
  var val = await col.findOne(where.eq('nombre', 'Martin'));
  //print(val);
  var res = val!.remove('_id');
  Jugador x = Jugador.fromMap(val);
  print(x);

  
  print("Terminado");
  await db.close();
}
