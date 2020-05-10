import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as HTTP;
import 'package:movies/models/movie_video.dart';

import 'actions.dart';
import 'states.dart';

class MovieVideosBloc extends Bloc<MovieVideosActions, MovieVideosState> {
  @override
  // TODO: implement initialState
  MovieVideosState get initialState => LoadingMovieVideosState();

  @override
  Stream<MovieVideosState> mapEventToState(MovieVideosActions event) async* {
    if (event is FetchMovieVideosAction)
      yield* _mapFetchMovieListActionToState(event.id);
  }

  Stream<MovieVideosState> _mapFetchMovieListActionToState(int id) async* {
    yield LoadingMovieVideosState();
    try {
      List<MovieVideo> movieVideos = await _fetchMovieVideos(id);
      yield LoadedMovieVideosState(movieVideos);
    } catch (_) {
      yield FailedMovieVideosState();
    }
  }

  Future<List<MovieVideo>> _fetchMovieVideos(int id) async {
    String url =
        'http://api.themoviedb.org/3/movie/$id/videos?api_key=802b2c4b88ea1183e50e6b285a27696e';
    try {
      HTTP.Response response = await HTTP.get(url);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        List result = res['results'];
        return result.map((movie) => MovieVideo.fromJSON(movie)).toList();
      } else
        throw Exception();
    } catch (e) {
      throw e;
    }
  }
}
