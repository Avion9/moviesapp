import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
//Controllers
import 'package:moviesapp/controllers/main_page_data_controller.dart';
import 'package:moviesapp/model/main_page_data.dart';

//Widgets
import 'package:moviesapp/widgets/movie_tile.dart';

//Models
import 'package:moviesapp/model/movie.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>(
  (ref) => MainPageDataController(),
);

//hinzugefügt, um Poster von jedem angeklickten Film als Hintergrund zu zeigen
final selectedMoviePosterURLProvider = StateProvider<String?>((ref) {
  final movies = ref.watch(mainPageDataControllerProvider).movies;
  return movies.isNotEmpty ? movies[0].posterURL() : null;
});

class MainPage extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWidth;

  late MainPageDataController? mainPageDataController;
  late MainPageData mainPageData;

  late TextEditingController searchTextFieldController;

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    mainPageDataController = ref.watch(mainPageDataControllerProvider.notifier);
    mainPageData = ref.watch(mainPageDataControllerProvider);

    var selectedMoviePosterURL = ref.watch(selectedMoviePosterURLProvider);

    searchTextFieldController = TextEditingController();

    searchTextFieldController.text = mainPageData.searchText;

    const border = InputBorder.none;

    final List<Movie> movies = mainPageData.movies;

    if (selectedMoviePosterURL != null) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: deviceHeight,
                width: deviceWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(selectedMoviePosterURL),
                      fit: BoxFit.cover),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.08, 0, 0),
                  width: deviceWidth * 0.88,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: deviceHeight * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          //zusätzliches SearchField Widget zum Schreiben des Textes in
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: deviceWidth * 0.80,
                                height: deviceHeight * 0.05,
                                child: TextField(
                                  controller: searchTextFieldController,
                                  onSubmitted: (input) => mainPageDataController
                                      ?.updateTextSearch(input),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    focusedBorder: border,
                                    border: border,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.white24,
                                    ),
                                    hintStyle: TextStyle(color: Colors.white54),
                                    filled: false,
                                    fillColor: Colors.white24,
                                    hintText: 'Search...',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: deviceHeight * 0.05,
                          width: deviceWidth * 0.8,
                          padding: EdgeInsets.only(right: deviceHeight * 0.10),
                        ),
                        Container(
                          height: deviceHeight * 0.74,
                          padding: EdgeInsets.only(top: deviceHeight * 0.01),
                          child: NotificationListener(
                            onNotification: (onScrollNotification) {
                              if (onScrollNotification
                                  is ScrollEndNotification) {
                                final before =
                                    onScrollNotification.metrics.extentBefore;
                                final max = onScrollNotification
                                    .metrics.maxScrollExtent;
                                if (before == max) {
                                  mainPageDataController?.getMovies();
                                  return true;
                                }
                                return false;
                              }
                              return false;
                            },
                            child: ListView.builder(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: movies.length,
                              itemBuilder: (BuildContext context, int count) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: deviceHeight * 0.01,
                                    horizontal: 0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(selectedMoviePosterURLProvider
                                              .notifier)
                                          .state = movies[count].posterURL();
                                    },
                                    child: MovieTile(
                                      movie: movies[count],
                                      height: deviceHeight * 0.23,
                                      width: deviceWidth * 0.85,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: deviceHeight,
        width: deviceWidth,
        color: Colors.black,
      );
    }
  }
}
