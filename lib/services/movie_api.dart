import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/movie_model.dart';

class MovieApi {
  static fetchNowPlayingMovies() async {
    final url =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=3e8e9dff41190dbcd93ca6f3ae559886";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    try {
      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body);
        final movieList = List<MovieModel>.from(
          (data["results"] as List).map((e) => MovieModel.fromJson(e)),
        );
        return movieList;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static fetchTrendingMovies() async {
    final url =
        "https://api.themoviedb.org/3/trending/movie/week?api_key=3e8e9dff41190dbcd93ca6f3ae559886";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    try {
      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body);
        final movieList = List<MovieModel>.from(
          (data["results"] as List).map((e) => MovieModel.fromJson(e)),
        );
        return movieList;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static fetchPopularTvShows() async {
    final url =
        "https://api.themoviedb.org/3/tv/popular?api_key=3e8e9dff41190dbcd93ca6f3ae559886";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    try {
      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body);
        final movieList = List<MovieModel>.from(
          (data["results"] as List).map((e) => MovieModel.fromJson(e)),
        );
        return movieList;
      }
    } catch (e) {
      print(e.toString());
    }
  }
  static fetchUpcomingMovies() async {
    final url =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=3e8e9dff41190dbcd93ca6f3ae559886";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    try {
      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body);
        final movieList = List<MovieModel>.from(
          (data["results"] as List).map((e) => MovieModel.fromJson(e)),
        );
        return movieList;
      }
    } catch (e) {
      print(e.toString());
    }
  }
  static fetchTopRatedMovies() async {
    final url =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=3e8e9dff41190dbcd93ca6f3ae559886";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    try {
      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body);
        final movieList = List<MovieModel>.from(
          (data["results"] as List).map((e) => MovieModel.fromJson(e)),
        );
        return movieList;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
