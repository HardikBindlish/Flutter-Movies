import 'package:moviezone/src/models/item_model.dart';
import 'api_provider.dart';

class Repository{
  ApiProvider apiProvider = ApiProvider();

  Future<List<Movie>> fetchMoviesList(){
    return apiProvider.fetchMovies();
  }
}
  
