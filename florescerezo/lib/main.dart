
import 'package:florescerezo/widget_screens/loading_widget.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ohanami',
      home: LoadingWidget(),
    );
  }
}
