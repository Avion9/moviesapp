import 'dart:developer';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

//Controllers
import 'package:moviesapp/controllers/main_page_data_controller.dart';
import 'package:moviesapp/model/main_page_data.dart';
import 'package:moviesapp/pages/Popular_page.dart';
import 'package:moviesapp/pages/Upcoming_page.dart';
import 'package:moviesapp/widgets/Desktop_movie_tile.dart';
import 'package:moviesapp/widgets/Mobile_movie_tile.dart';

//Widgets
import 'package:moviesapp/widgets/movie_tile.dart';

//Models
import 'package:moviesapp/model/movie.dart';
import 'package:moviesapp/widgets/responsive_Layout.dart';
import 'package:moviesapp/model/search_category.dart';
//Buttons

import '../Buttons/button_custom_Desktop.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>(
  (ref) => MainPageDataController(),
);

//hinzugefügt, um Poster von jedem angeklickten Film als Hintergrund zu zeigen
final selectedMoviePosterURLProvider = StateProvider<String?>((ref) {
  final movies = ref.watch(mainPageDataControllerProvider).movies;
  return movies.isNotEmpty ? movies[0].posterURL() : null;
});
/* final selectedMovieCategoryProvider = StateProvider<String?>((ref) {
  final Category = ref.watch(mainPageDataControllerProvider).searchCategory;
  return movies.isNotEmpty ? movies[0].posterURL() : null;
}); */

class Top_Rated_Page extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWidth;

  late MainPageDataController? mainPageDataController;
  late MainPageData mainPageData;

  late TextEditingController searchTextFieldController;
  late String category;

  Top_Rated_Page({Key? key, required this.category}) : super(key: key);

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

    final List<String> items = [
      SearchCategory.Popular,
      SearchCategory.TopRated,
      SearchCategory.upcoming,
    ];

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
              //return to the recent page
              /*   Align(
                alignment: AlignmentDirectional(-1, 0.05),
                child: RaisedButton(
                  onPressed: () {
                    context.);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ), */
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
                                width: deviceWidth * 0.88 - 100,
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
                              CustomDesktopDropdownButton2(
                                  hint: '',
                                  dropdownItems: items,
                                  onChanged: (value) =>
                                      Selecteditem(context, value.toString())),

                              /* CustomDesktopDropdownButton2(
                                Selecteditem(context, 0)
                                hint: '',
                                dropdownItems: items,
                                onChanged: (value) => value
                                        .toString()
                                        .isNotEmpty
                                    ? mainPageDataController
                                        ?.updateSearchCategory(value.toString())
                                    : null,
                              ) */
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
                                    child: ResponsiveLayout(
                                      mobileBody: Mobile_movie_tile(
                                          movie: movies[count],
                                          height: deviceHeight * 0.23,
                                          width: deviceWidth * 0.85),
                                      DesktopBody: Desktop_movie_tile(
                                          movie: movies[count],
                                          height: deviceHeight * 0.20,
                                          width: deviceWidth * 0.88),
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

  void Selecteditem(BuildContext context, String category) {
    switch (category) {
      case 'Popular':
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Popular_Page()),
            (route) => true);
        break;
      case 'Top Rated':
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Top_Rated_Page(category: category)),
            (route) => true);
        break;
      case 'Upcoming':
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Upcoming_Page()),
            (route) => true);
        break;
      default:
    }
  }
}
