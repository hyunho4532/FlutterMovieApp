import 'package:dio/dio.dart';
import 'package:movie_app_project/model/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';

  final String apiKey = 'ff5fd275ee5111ed49345c916c46c177';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final response = await _dio.get('$baseUrl/movie/popular?language=ko-KR&$apiKey');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stackTrace) {
      throw Exception('Exception accrued: $error with stackTrace: $stackTrace');
    }
  }
}