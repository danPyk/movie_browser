import 'package:get_it/get_it.dart';
import 'package:movie_browser/models/main_page_data.dart';
import 'package:movie_browser/models/movie.dart';
import 'package:movie_browser/models/search_category.dart';
import 'package:movie_browser/services/movie_service.dart';
import 'package:riverpod/riverpod.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie>? _movies = [];

      if (state.searchCategory!.isNotEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          _movies = await _movieService.getMovies('popular', page: state.page!);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          _movies =
              await _movieService.getMovies('upcoming', page: state.page!);
        } else if (state.searchCategory == SearchCategory.none) _movies = [];
      } else {
        //perform text search
        _movies = await _movieService.searchMovies(state.searchText);
      }
      //everytime when somethings changing in state, state is updated
      state =
          state.copyWith(movies: [...?state.movieList, ...?_movies], page: state.page! + 1);
    } catch (e) {
      print(e);
    }
  }

  void updateSearchCategory(String _category) {
    try {
      state = state.copyWith(movies: [], page:  1,searchCategory:  _category, searchText: '');
      getMovies();
    } catch (e) {
      print(e);
    }
  }

  void updateTextSearch(String _searchText) {
    try {
      state = state.copyWith(movies: [],page:  1, searchCategory: SearchCategory.none,searchText:  _searchText);
      getMovies();
    } catch (e) {
      print(e);
    }
  }
}
