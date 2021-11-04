import 'package:get_it/get_it.dart';
import 'package:movie_browser/models/app_config.dart';

class Movie {
  final String? name;
  final String? language;
  final bool? adult;
  final String? description;
  final String? posterPath;
  final String? backdropPath;
  final num? rating;
  final String? release;

  Movie({this.name, this.language, this.adult, this.description, this.posterPath, this.backdropPath, this.rating, this.release,

  });

  factory Movie.fromJson(Map<String, dynamic> _json) {
    return Movie(
      name: _json['title'],
      language: _json['original_language'],
      adult: _json['adult'],
      description: _json['overview'],
      posterPath: 'https://image.tmdb.org/t/p/w500/'+_json['poster_path'],
      backdropPath: _json['backdrop_path'],
      rating: _json['vote_average'],
      release: _json['release_date'],
    );
  }

  String posterUrl(){
    final AppConfig _appConfing = GetIt.instance.get<AppConfig>();
    return '${_appConfing.BASE_IMAGE_API_URL}${this.posterPath}';
  }
}
