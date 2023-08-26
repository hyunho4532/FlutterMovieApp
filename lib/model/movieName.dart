
class MovieName {
  String movieName = "";

  MovieName(this.movieName);
}

class MovieNameManager {
  late MovieName _movieName;

  MovieName get movieName => _movieName;

  set movieName(MovieName movieName) {
    _movieName = movieName;
  }
}