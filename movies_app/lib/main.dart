import 'package:flutter/material.dart';
import 'package:movies_app/src/presentation/pages/details_page.dart';
import 'package:movies_app/src/presentation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies in Theaters',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'details': (BuildContext context) => DetailsPage(),
      },
    );
  }
}
