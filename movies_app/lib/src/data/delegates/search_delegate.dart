import 'package:flutter/material.dart';
import 'package:movies_app/src/data/providers/movie_provider.dart';
import 'package:movies_app/src/domain/model/movies.dart';

class DataSearchDelegate extends SearchDelegate {
  final provider = MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: provider.searchMovie(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
            children: movies.map((movie) {
              return _createListTile(context, movie);
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createListTile(BuildContext context, Movie movie) {
    return ListTile(
      leading: FadeInImage(
        image: NetworkImage(movie.getPosterImage()),
        placeholder: AssetImage('assets/images/no-image.jpg'),
        width: 50.0,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        close(context, null);
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
