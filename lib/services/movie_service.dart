import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_browser/models/movie.dart';
import 'package:movie_browser/services/http_service.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService _httpService;

  MovieService() {
    _httpService = getIt.get<HTTPService>();
  }

  Future<List<Movie>?> getMovies(String criteria, {int? page}) async {
    Response? _response = await _httpService.get('/movie/$criteria', query: {
      'page': page,
    });
    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception('Couldn\'t load popular movies.');
    }
  }

  Future<List<Movie>?> searchMovies(String? criteria, {int? page}) async {
    Response? _response = await _httpService.get('/search/movie', query: {
      'query': criteria,
      'page': page,
    });
    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception('Couldn\'t perform movies search.');
    }
  }
}
