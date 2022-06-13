import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/data/providers/base_provider.dart';
import 'package:movies_app/src/domain/model/casting.dart';

class CastProvider extends BaseProvider<Casting> {

  Future<List<Cast>> getCastMovie(String movieId) async {
    final url = Uri.https(base_url, '3/movie/$movieId/credits', {
      'api_key': apiKey,
    });

    Casting casting = await processResponse(url);
    return casting.cast;
  }

  Future<Casting> processResponse(Uri uri) async {
    final response = await http.get(uri);
    final decodeData = json.decode(response.body);
    return Casting.fromJson(decodeData);
  }
}
