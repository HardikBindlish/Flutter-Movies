import 'package:flutter/material.dart';
import 'package:moviezone/src/Bloc/moviestopprovider.dart';
import 'package:moviezone/src/screens/home_screen.dart';
import 'package:moviezone/src/Bloc/moviesprovider.dart';

class App extends StatelessWidget{
  Widget build(context){
    return MoviesProvider(
      child: MoviesTopProvider(
        child: MaterialApp(
        title: 'Movies Zone',
        home: HomeScreen(),
        ),
      ) 
    );
  } 
}