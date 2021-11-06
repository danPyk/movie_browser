import 'package:movie_browser/models/movie.dart';
import 'package:movie_browser/models/search_category.dart';

class MainPageData {
  final List<Movie>? movieList;
  final int? page;
  final String? searchCategory;
  final String searchText;

  MainPageData(this.movieList, this.page, this.searchCategory, this.searchText);

  MainPageData.initial()
      : movieList = [],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = '';

  MainPageData copyWith(
      {List<Movie>? movies,
        int? page,
        String? searchCategory,
        String? searchText}) {
    return MainPageData(
     movies ?? this.movieList,
        page ?? this.page,
      searchCategory ?? this.searchCategory,
     searchText ?? this.searchText);
  }
}
