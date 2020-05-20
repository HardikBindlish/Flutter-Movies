import 'package:flutter/material.dart';
import 'package:moviezone/src/screens/movies_list.dart';
import 'package:moviezone/src/Bloc/moviesprovider.dart';

class App extends StatelessWidget{
  Widget build(context){
    return MoviesProvider(
      child:  MaterialApp(
        title: 'Movies Zone',
        home: MoviesList(),
      ),
    );
  } 
}