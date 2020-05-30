import 'package:rxdart/rxdart.dart';
import 'package:moviezone/src/models/item_model_top.dart';
import 'dart:convert';
import 'package:http/http.dart' show Client;

class MoviesTopBloc{
  Client client = Client();
  final _movies = PublishSubject<List<TopMovie>>();

  Stream<List<TopMovie>> get topMovies => _movies.stream;

  Function(List<TopMovie>) get tChangeMovies => _movies.sink.add;
  
  dispose(){
    _movies.close();
  }

  Future<void> fetchTrendingMovies() async{
    final response = await client.get('http://harsh4861.pythonanywhere.com/api/fetch/?type=M');
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      List<TopMovie> list1 = List<TopMovie>();
      List<TopMovie> list2 = List<TopMovie>();

      // list1 = data['recent'];

      data.recent.forEach((movie) => {list1.add(TopMovie.fromJson(movie))});
      print(list1);

      // data.forEach((movie) => {list1.add(TopMovie.fromJson(movie))});
      // tChangeMovies(list1);

      // movies.forEach((movie) => print(movie.topRated));
    }
    else{
      throw Exception('Falied to get movies list');
    }
  }

}