import 'package:flutter/material.dart';
import 'moviestopbloc.dart';
export 'moviestopbloc.dart';

class MoviesTopProvider extends InheritedWidget{
  final MoviesTopBloc tbloc;

  MoviesTopProvider({Key key, Widget child})
    : tbloc = MoviesTopBloc(),
    super(key: key, child: child);

    bool updateShouldNotify(_) => true;

    static MoviesTopBloc of(BuildContext context){
      return(context.dependOnInheritedWidgetOfExactType<MoviesTopProvider>()).tbloc;
    }
}