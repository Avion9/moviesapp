//Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//pages
import './pages/Splash_page.dart';
import './pages/Main_page.dart';

void main() {
  runApp(
    SplashPage(
        key: UniqueKey(),
        onIntializationComplete: () => runApp(const ProviderScope(
              child: MyApp(),
            ))),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //Dieses Widget ist die Basis(root) der Anwendung.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cine4u',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => MainPage(),
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
