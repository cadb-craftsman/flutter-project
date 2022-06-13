abstract class BaseProvider<T> {
  String apiKey = '23647234a00b353f9dbe43cc884a7150';
  String base_url = 'api.themoviedb.org';
  String language = 'es-ES';

  Future<T> processResponse(Uri uri);
}

