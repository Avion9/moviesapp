//Packages
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
//Models
import 'package:moviesapp/model/main_page_data.dart';
import 'package:moviesapp/model/movie.dart';
import 'package:moviesapp/model/search_category.dart';
//Services
import 'package:moviesapp/services/movie_service.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.inital()) {
    getMovies();
  }

  final MovieService movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> movies = [];
      if (state.searchText.isEmpty) {
        if (state.searchCategory == SearchCategory.Popular) {
          movies = await movieService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          movies = await movieService.getUpcomingMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.TopRated) {
          movies = await movieService.getTopRatedMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.none) {
          movies = [];
        }
      } else {
        movies = await movieService.searchMovies(
            searchTerm: state.searchText, page: state.page);
      }
      state = state
          .copyWith(movies: [...state.movies, ...movies], page: state.page + 1);
    } catch (e) {
      print("error");
    }
  }

  void updateSearchCategory(String category) {
    try {
      state = state.copyWith(
          movies: [], page: 1, searchCategory: category, searchText: '');
      getMovies();
    } catch (e) {
      print(e);
    }
  }

  void updateTextSearch(String searchText) {
    try {
      state = state.copyWith(
        movies: [],
        page: 1,
        searchText: searchText,
      );
      getMovies();
    } catch (e) {
      print(e);
    }
  }
}
