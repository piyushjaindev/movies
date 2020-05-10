import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/movie_videos/bloc.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movie_video.dart';
import 'package:movies/screens/error.dart';
import 'package:movies/screens/loading.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  MovieDetails(this.movie);
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Movie movie;
  @override
  void initState() {
    movie = widget.movie;
    BlocProvider.of<MovieVideosBloc>(context)
        .add(FetchMovieVideosAction(movie.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        centerTitle: true,
      ),
      body: BlocBuilder<MovieVideosBloc, MovieVideosState>(
        builder: (context, state) {
          if (state is LoadingMovieVideosState) return Loading();
          if (state is FailedMovieVideosState) return ErrorPage();
          if (state is LoadedMovieVideosState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w1280_and_h720_face${movie.backgroundImage}',
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  movie.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(movie.overview),
                ),
                SizedBox(height: 10.0),
                Expanded(child: MovieVideos(state.movieVideos)),
              ],
            );
          }
          return Loading();
        },
      ),
    );
  }
}

class MovieVideos extends StatelessWidget {
  final List<MovieVideo> movieVideos;
  MovieVideos(this.movieVideos);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movieVideos.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Text('id: ${movieVideos[index].id}'),
              Text('name: ${movieVideos[index].name}'),
              Text('type: ${movieVideos[index].type}')
            ],
          );
        });
  }
}
