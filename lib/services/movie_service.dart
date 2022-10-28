import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviesapp/model/movie.dart';
//Services
import 'dart:developer';
import 'package:moviesapp/services/http_service.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService http;

  MovieService() {
    http = getIt.get<HTTPService>();
  }

  Future<List<Movie>> getTopRatedMovies({int? page}) async {
    Response? response = await http.get('/movie/top_rated', query: {
      'page': page,
    });
    //Wenn die "statusCode" 200 ist, haben wir eine korrekte Antwort erhalten.
    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load top Rated Movies.');
    }
  }

  Future<List<Movie>> searchMovies({String? searchTerm, int? page}) async {
    Response? response = await http.get('/search/movie', query: {
      'query': searchTerm,
      'page': page,
    });
    //Wenn die "statusCode" 200 ist, haben wir eine korrekte Antwort erhalten.
    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        try {
          Movie returned_movie = Movie.fromJson(movieData);
          return returned_movie;
        } catch (e) {
          return Movie.emptyMovie();
        }
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t search the Movie.');
    }
  }
}
