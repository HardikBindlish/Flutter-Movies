class Movie{
  final int id;
  final String title;
  final String story;
  final String releaseDate;
  final List<Genre> genre ;
  final String rating;
  final String image;
  final String download;
  final String category;
  final String createDate;
  final String trailer;
  final String downloadSize;

  Movie({
    this.id,
    this.title,
    this.story, 
    this.releaseDate, 
    this.genre, 
    this.rating, 
    this.image, 
    this.download, 
    this.category, 
    this.createDate, 
    this.trailer, 
    this.downloadSize, 
  });

  Movie.fromJson(Map<String, dynamic> parsedjson)
    : id = parsedjson['id'],
      title = parsedjson['title'],
      story = parsedjson['story'],
      releaseDate = parsedjson['releaseDate'],
      genre = (parsedjson['genre'] as List).map((i) => Genre.fromJson(i)).toList(),
      rating = parsedjson['rating'],
      image = parsedjson['image'],
      download = parsedjson['download'],
      category = parsedjson['category'],
      createDate = parsedjson['createDate'],
      trailer = parsedjson['trailer'],
      downloadSize = parsedjson['downloadSize'];

  //  Map<String, dynamic> toJson() =>
  //   {
  //     'id': id,
  //     'title': title,
  //     'story': story,
  //     'releaseDate': releaseDate,
  //     'genre': genre,
  //     'rating': rating,
  //     'image': image,
  //     'download': download,
  //     'category': category,
  //     'createDate': createDate,
  //     'trailer': trailer,
  //     'downloadSize': downloadSize
  //   };
}

class Genre {
  final int id;
  final String genre;

  Genre(this.id, this.genre);

  Genre.fromJson(Map<String, dynamic> jsonMap)
    : id = jsonMap['id'],
      genre = jsonMap['name'];
}