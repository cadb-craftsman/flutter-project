import 'package:flutter/material.dart';
import 'package:movies_app/src/domain/model/casting.dart';


class CardCast extends StatelessWidget {
  final List<Cast> casts;

  CardCast({@required this.casts});

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        //nextPage();
      }
    });

    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: casts.length,
        itemBuilder: (context, i) {
          return getCard(context, casts[i]);
        },
        //children: _getCards(context),
      ),
    );
  }

  Widget getCard(BuildContext context, Cast cast) {
    final _screenSize = MediaQuery.of(context).size;
    final movieCard = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(cast.getProfileImage()),
              placeholder: AssetImage('assets/images/no-image.jpg'),
              fit: BoxFit.cover,
              height: _screenSize.height * 0.2,
            ),
          ),
          SizedBox(
            height: 20.0,
            child: Text(
              cast.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: movieCard,
      onTap: () {
        //Navigator.pushNamed(context, 'details', arguments: card);
      },
    );
  }
}
