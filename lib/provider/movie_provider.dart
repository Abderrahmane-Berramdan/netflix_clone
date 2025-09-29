import 'package:flutter/foundation.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/services/movie_api.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieModel> nowPlayingMoviesList = [];
  List<MovieModel> trendingMoviesList = [];
  List<MovieModel> popularTvShowsList = [];
  List<MovieModel> upcomingMoviesList = [];
  List<MovieModel> topRatedMoviesList = [];
  bool isLoading = false;

  fetchNowPlayingMovies() async {
    isLoading = true;
    final nowPlayingMoviesResponse = await MovieApi.fetchNowPlayingMovies();
    nowPlayingMoviesList = nowPlayingMoviesResponse;
    isLoading = false;
    notifyListeners();
  }

  fetchTrendingMovies() async {
    isLoading = true;
    final trendingMovieResponse = await MovieApi.fetchTrendingMovies();
    trendingMoviesList = trendingMovieResponse;
    isLoading = false;
    notifyListeners();
  }

  fetchPopularTvShows() async {
    isLoading = true;
    final popularTvResponse = await MovieApi.fetchPopularTvShows();
    popularTvShowsList = popularTvResponse;
    isLoading = false;
    notifyListeners();
  }

  fetchUpcomingMovies() async {
    isLoading = true;
    final upcomingMoviesResponse = await MovieApi.fetchUpcomingMovies();
    upcomingMoviesList = upcomingMoviesResponse;
    isLoading = false;
    notifyListeners();
  }

  fetchTopRatedMovies() async {
    isLoading = true;
    final topRatedMoviesResponse = await MovieApi.fetchTopRatedMovies();
    topRatedMoviesList = topRatedMoviesResponse;
    isLoading = false;
    notifyListeners();
  }
}
