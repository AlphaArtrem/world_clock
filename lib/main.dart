import 'package:flutter/material.dart';
import 'package:worldclock/src/home.dart';
import 'package:worldclock/src/loading.dart';
import 'package:worldclock/src/location.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'World Clock',
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => Location(),
    },
  ));
}