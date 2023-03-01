import 'package:moviesapp/model/movie.dart';
import 'package:moviesapp/model/search_category.dart';

class MainPageData {
  final List<Movie> movies;
  final int page;
  final String searchText;
  final String searchCategory;

  MainPageData(
      {required this.movies,
      required this.page,
      required this.searchCategory,
      required this.searchText});

  MainPageData.inital()
      : movies = [],
        page = 1,
        searchCategory = SearchCategory.Popular,
        searchText = '';

  MainPageData copyWith(
      {List<Movie>? movies,
      int? page,
      String? searchCategory,
      String? searchText}) {
    return MainPageData(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
    );
  }
}
