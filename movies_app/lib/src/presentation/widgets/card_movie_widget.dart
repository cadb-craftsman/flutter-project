import 'package:flutter/material.dart';
import 'package:movies_app/src/domain/model/movies.dart';

class CardMovie extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  CardMovie({@required this.movies, @required this.nextPage});

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i) {
          return getCard(context, movies[i]);
        },
        //children: _getCards(context),
      ),
    );
  }

  Widget getCard(BuildContext context, Movie movie) {
    final _screenSize = MediaQuery.of(context).size;
    movie.movieId = '${movie.id}-card-movie';
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.movieId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: FadeInImage(
                  image: NetworkImage(movie.getPosterImage()),
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: _screenSize.height * 0.2,
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'details', arguments: movie);
                },
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          )
        ],
      ),
    );
  }
}
