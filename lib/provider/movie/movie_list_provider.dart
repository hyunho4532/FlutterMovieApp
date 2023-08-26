import 'package:flutter/material.dart';

class MovieListProvider extends ChangeNotifier {
  List<dynamic> _movieList = [];

  List<dynamic> get movieList => _movieList;

  set movieList(List<dynamic> newList) {
    _movieList = newList;
    notifyListeners();
  }

  void updateMovieList(List<dynamic> newMovieList) {
    movieList = newMovieList;
  }
}