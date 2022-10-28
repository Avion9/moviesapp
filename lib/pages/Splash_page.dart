import 'dart:convert';
//Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
//Model
import 'package:moviesapp/model/app_config.dart';
//Services
import 'package:moviesapp/services/http_service.dart';
import 'package:moviesapp/services/movie_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onIntializationComplete;

  const SplashPage({
    Key? key,
    required this.onIntializationComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    //This is to show The SplashPage for 2 second
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => setup(context).then(
        (value) => widget.onIntializationComplete(),
      ),
    );
  }

//this Function "Setup" to obtain and read the Data from the main.json File
  Future<void> setup(BuildContext context) async {
    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString('assets/Config/main.json');
    final configData = jsonDecode(configFile);
    //Calling AppConfig
    getIt.registerSingleton<AppConfig>(
      AppConfig(
        BASE_API_URL: configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
        API_KEY: configData['API_KEY'],
      ),
    );
    //Calling HTTPServices
    getIt.registerSingleton<HTTPService>(
      HTTPService(),
    );

    //Calling MovieService
    getIt.registerSingleton<MovieService>(
      MovieService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading...',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
          child: Container(
        height: 200,
        width: 200,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/Images/logo.png'))),
      )),
    );
  }
}
