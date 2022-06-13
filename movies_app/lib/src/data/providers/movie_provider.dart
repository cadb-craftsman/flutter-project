import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/data/providers/base_provider.dart';
import 'package:movies_app/src/domain/model/movies.dart';

class MoviesProvider extends BaseProvider<Movies> {
  int _countPagePopulates = 0;
  bool _loading = false;

  final List<Movie> _populateList = [];
  final _populateStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get populateSink => _populateStreamController.sink.add;

  Stream<List<Movie>> get populateStream => _populateStreamController.stream;

  void disposeStreams() {
    _populateStreamController?.close();
  }

  Future<Movies> getInTheaters() async {
    final url = Uri.https(base_url, '3/movie/now_playing',
        {'api_key': apiKey, 'language': language});
    return await processResponse(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    if (_loading) return [];

    _loading = true;
    _countPagePopulates++;

    final url = Uri.https(base_url, '3/movie/popular', {
      'api_key': apiKey,
      'language': language,
      'page': _countPagePopulates.toString()
    });

    final response = await processResponse(url);
    _populateList.addAll(response.movieList);
    populateSink(_populateList);
    _loading = false;
    return response.movieList;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(base_url, '3/search/movie',
        {'api_key': apiKey, 'language': language, 'query': query});
    final response = await processResponse(url);
    return response.movieList;
  }

  Future<Movies> processResponse(Uri uri) async {
    final response = await http.get(uri);
    final decodeData = json.decode(response.body);
    return Movies.fromJson(decodeData);
  }
}
