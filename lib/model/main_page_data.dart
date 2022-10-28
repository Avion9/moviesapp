import 'package:moviesapp/model/movie.dart';

class MainPageData {
  final List<Movie> movies;
  final int page;
  final String searchText;

  MainPageData(
      {required this.movies, required this.page, required this.searchText});

  MainPageData.inital()
      : movies = [],
        page = 1,
        searchText = '';

  MainPageData copyWith({List<Movie>? movies, int? page, String? searchText}) {
    return MainPageData(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchText: searchText ?? this.searchText,
    );
  }
}
