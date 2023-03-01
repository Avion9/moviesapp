import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
//Models
import '../model/movie.dart';

class Desktop_movie_tile extends StatelessWidget {
  final GetIt getIt = GetIt.instance;

  final double height;
  final double width;
  final Movie movie;

  Desktop_movie_tile(
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
            height: height * 1.5,
            width: width * 0.20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie.posterURL()),
                alignment: Alignment.bottomLeft,
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
      height: height * 1.4,
      width: width * 0.80,
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
                width: width * 0.50,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.04,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
            child: Text(
              '${movie.language.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}',
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.015,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
            child: Text(
              movie.description,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: width * 0.014),
            ),
          ),
        ],
      ),
    );
  }
}
