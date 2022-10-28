//Packages
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

//Models
import 'package:moviesapp/model/app_config.dart';

class Movie {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  String posterPath;
  final String backdroppath;
  final num rating;
  final String releaseDate;

  Movie(
      {required this.name,
      required this.language,
      required this.isAdult,
      required this.description,
      required this.posterPath,
      required this.backdroppath,
      required this.rating,
      required this.releaseDate});

//Rückgabe der Objektinstanzierung eines Films aus seiner json-Darstellung.
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        name: json['title'] ?? "",
        language: json['original_language'] ?? "",
        isAdult: json['adult'] ?? false,
        description: json['overview'] ?? "",
        posterPath: json['poster_path'] ?? "",
        backdroppath: json['backdrop_path'] ?? "",
        rating: json['vote_average'] ?? 0,
        releaseDate: json['release_date'] ?? "");
  }

  //Funktion zum Abrufen der PosterUrl.
  String posterURL() {
    final AppConfig appconfig = GetIt.instance.get<AppConfig>();
    return '${appconfig.BASE_IMAGE_API_URL}$posterPath';
  }

//Modified
  factory Movie.emptyMovie() {
    return Movie(
        name: "",
        language: "",
        isAdult: false,
        description: "",
        posterPath: "",
        backdroppath: "",
        rating: 0,
        releaseDate: "");
  }
}
