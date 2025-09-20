import 'package:flutter/foundation.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/services/movie_api.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieModel> nowPlayingMoviesList = [];
  List<MovieModel> trendingMoviesList = [];
  List<MovieModel> popularTvShowsList = [];
  List<MovieModel> upcomingMoviesList = [];
  List<MovieModel> topRatedMoviesList = [];

  fetchNowPlayingMovies() async {
    final nowPlayingMoviesResponse = await MovieApi.fetchNowPlayingMovies();
    nowPlayingMoviesList = nowPlayingMoviesResponse;
    notifyListeners();
  }
  fetchTrendingMovies() async {
    final trendingMovieResponse = await MovieApi.fetchTrendingMovies();
    trendingMoviesList = trendingMovieResponse;
    notifyListeners();
  }
  fetchPopularTvShows() async {
    final popularTvResponse = await MovieApi.fetchPopularTvShows();
    popularTvShowsList = popularTvResponse;
    notifyListeners();
  }
  fetchUpcomingMovies() async {
    final upcomingMoviesResponse = await MovieApi.fetchUpcomingMovies();
    upcomingMoviesList = upcomingMoviesResponse;
    notifyListeners();
  }
  fetchTopRatedMovies() async {
    final topRatedMoviesResponse = await MovieApi.fetchTopRatedMovies();
    topRatedMoviesList = topRatedMoviesResponse;
    notifyListeners();
  }
  // fetchSearchMovies() async {
  //   final searchMovieResponse = await MovieApi.fetchSearchMovies(String movieName);
  //   se = searchMovieResponse;
  //   notifyListeners();
  // }
}
