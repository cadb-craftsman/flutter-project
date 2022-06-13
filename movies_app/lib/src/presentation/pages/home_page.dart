import 'package:flutter/material.dart';
import 'package:movies_app/src/data/delegates/search_delegate.dart';

import 'package:movies_app/src/data/providers/movie_provider.dart';
import 'package:movies_app/src/presentation/widgets/card_swipe_widget.dart';
import 'package:movies_app/src/presentation/widgets/card_movie_widget.dart';

class HomePage extends StatelessWidget {
  final provider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    provider.getPopularMovies();

    return Scaffold(
        appBar: AppBar(
          title: Text('Movies in Theaters'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearchDelegate(), query: 'Introduce una pelicula');
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swipeCards(context),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swipeCards(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: provider.getInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: _screenSize.height * 0.4,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: provider.populateStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return CardMovie(
                    movies: snapshot.data, nextPage: provider.getPopularMovies);
              } else {
                return Container(
                  height: _screenSize.height * 0.2,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
