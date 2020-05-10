import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/movie_list/bloc.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/error.dart';
import 'package:movies/screens/loading.dart';
import 'package:movies/screens/movie_details.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Movies'),
          centerTitle: true,
        ),
        body: BlocBuilder<MovieListBloc, MovieListState>(
          builder: (context, state) {
            if (state is LoadingMovieListState) return Loading();
            if (state is FailedMovieListState) return ErrorPage();
            if (state is LoadedMovieListState) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemCount: state.movieList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      MovieWidget(state.movieList[index]));
            }
            return Loading();
          },
        ));
  }
}

class MovieWidget extends StatelessWidget {
  final Movie movie;

  MovieWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MovieDetails(movie)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Card(
          elevation: 12.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Image.network(
                'https://image.tmdb.org/t/p/w220_and_h330_face${movie.image}',
                fit: BoxFit.cover,
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Text(movie.title),
              )
            ],
          ),
        ),
      ),
    );
  }
}
