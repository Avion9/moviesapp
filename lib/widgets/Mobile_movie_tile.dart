import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
//Models
import '../model/movie.dart';

class Mobile_movie_tile extends StatelessWidget {
  final GetIt getIt = GetIt.instance;

  final double height;
  final double width;
  final Movie movie;

  Mobile_movie_tile(
      {Key? key,
      required this.height,
      required this.movie,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie.posterURL()),
              ),
            ),
          ),
          movieInfoWidget(),
        ],
      ),
    );
  }

//das Widget enthält die Beschreibung und Informationen über Filme
  Widget movieInfoWidget() {
    return Container(
      height: height,
      width: width * 0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.56,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              '${movie.language.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
            child: Text(
              movie.description,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: width * 0.022),
            ),
          ),
        ],
      ),
    );
  }
}
