import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:moviezone/src/models/item_model.dart';

class ApiProvider{
  Client client = Client();

  Future<List<Movie>> fetchMovies() async{
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/movie/');
    if(response.statusCode == 200){
      final data = json.decode(response.body) as List;
      List<Movie> movies = List<Movie>();

      data.forEach((movie) => {movies.add(Movie.fromJson(movie))});
      movies.forEach((movie) => print(movie.title));
      return movies;
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

  // Future<Movie> fetchItem(int id) async{
  //   final response = await client.get('http://harsh4861.pythonanywhere.com/api/movie/$id');
  //   final parsedjson = json.decode(response.body);
  //   return Movie.fromJson(parsedjson); 
  // }
}