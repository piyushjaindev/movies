import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as HTTP;
import 'package:movies/models/movie.dart';

import 'actions.dart';
import 'states.dart';

class MovieListBloc extends Bloc<MovieListActions, MovieListState> {
  @override
  MovieListState get initialState => LoadingMovieListState();

  @override
  Stream<MovieListState> mapEventToState(MovieListActions event) async* {
    if (event is FetchMovieListAction) yield* _mapFetchMovieListActionToState();
  }

  Stream<MovieListState> _mapFetchMovieListActionToState() async* {
    yield LoadingMovieListState();
    try {
      List<Movie> moviesList = await _fetchMovieList();
      yield LoadedMovieListState(moviesList);
    } catch (_) {
      yield FailedMovieListState();
    }
  }

  Future<List<Movie>> _fetchMovieList() async {
    String url =
        'http://api.themoviedb.org/3/movie/popular?api_key=802b2c4b88ea1183e50e6b285a27696e';
    try {
      HTTP.Response response = await HTTP.get(url);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        List result = res['results'];
        return result.map((movie) => Movie.fromJSON(movie)).toList();
      } else
        throw Exception();
    } catch (e) {
      throw e;
    }
  }
}
