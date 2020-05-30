import 'package:moviezone/src/models/item_model.dart';

class TopMovie{
  final List<Movie> recent;
  final List<Movie> topRated;

  TopMovie({
    this.recent,
    this.topRated
  });

  TopMovie.fromJson(Map<String, dynamic> parsedjson)
    : recent = parsedjson['recent'],
      topRated = parsedjson['top_rated'];
}

