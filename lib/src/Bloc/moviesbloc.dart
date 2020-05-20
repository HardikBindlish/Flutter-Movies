import 'package:rxdart/rxdart.dart';
import 'package:moviezone/src/models/item_model.dart';
import 'dart:convert';
import 'package:http/http.dart' show Client;

class MoviesBloc{
  Client client = Client();
  final _movies = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get movies => _movies.stream;

  Function(List<Movie>) get changeMovies => _movies.sink.add;
  
  dispose(){
    _movies.close();
  }

  Future<void> fetchMovies() async{
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/movie');
    if(response.statusCode == 200){
      final data = json.decode(response.body) as List;
      List<Movie> movies = List<Movie>();

      data.forEach((movie) => {movies.add(Movie.fromJson(movie))});
      changeMovies(movies);

      movies.forEach((movie) => print(movie.title));
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

}