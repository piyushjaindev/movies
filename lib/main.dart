import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/movie_list/bloc.dart';
import 'bloc/movie_videos/bloc.dart';
import 'screens/movie_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => MovieListBloc()..add(FetchMovieListAction()),
        ),
        BlocProvider<MovieVideosBloc>(
          create: (context) => MovieVideosBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MovieList(),
      ),
    );
  }
}
