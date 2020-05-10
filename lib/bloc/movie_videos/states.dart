import 'package:movies/models/movie_video.dart';

abstract class MovieVideosState {}

class LoadingMovieVideosState extends MovieVideosState {}

class LoadedMovieVideosState extends MovieVideosState {
  List<MovieVideo> movieVideos;
  LoadedMovieVideosState(this.movieVideos);
}

class FailedMovieVideosState extends MovieVideosState {}
