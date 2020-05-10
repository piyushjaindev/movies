import 'package:movies/models/movie.dart';

abstract class MovieListState {}

class LoadingMovieListState extends MovieListState {}

class LoadedMovieListState extends MovieListState {
  List<Movie> movieList;

  LoadedMovieListState(this.movieList);
}

class FailedMovieListState extends MovieListState {}
