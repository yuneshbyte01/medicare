import 'package:flutter/material.dart';

void main() => runApp(MediTrackApp());

class MediTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediTrack',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        appBar: AppBar(title: Text('MediTrack')),
        body: Center(child: Text('Welcome to MediTrack Mobile')),
      ),
    );
  }
}
