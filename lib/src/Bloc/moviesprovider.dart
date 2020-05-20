import 'package:flutter/material.dart';
import 'moviesbloc.dart';
export 'moviesbloc.dart';

class MoviesProvider extends InheritedWidget{
  final MoviesBloc bloc;

  MoviesProvider({Key key, Widget child})
    : bloc = MoviesBloc(),
    super(key: key, child: child);

    bool updateShouldNotify(_) => true;

    static MoviesBloc of(BuildContext context){
      return(context.dependOnInheritedWidgetOfExactType<MoviesProvider>()).bloc;
    }
}