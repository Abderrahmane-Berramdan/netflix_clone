import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/services/movie_api.dart';
import 'package:netflix_clone/widgets/search_results_list.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<MovieModel> searchMoviesList = [];
  String movieName = "";

  void fetchSearchMovie(String movieName) async {
    final searchMovieResponse = await MovieApi.fetchSearchMovies(movieName);
    if (!mounted) return;
    setState(() {
      searchMoviesList = searchMovieResponse;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<MovieProvider>().fetchTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: ListView(
            children: [
              SearchBar(
                onSubmitted: (value) {
                  movieName = value.trim();
                  fetchSearchMovie(movieName);
                },
                leading: Icon(Icons.search, color: Colors.grey[700]),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(15),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(Colors.grey[900]),
                hintText: "Search",
                hintStyle: WidgetStatePropertyAll(
                  TextStyle(color: Colors.grey[700]),
                ),
                textStyle: WidgetStatePropertyAll(TextStyle(color: white)),
              ),
              SizedBox(height: 20),
              Text(
                "Top Search",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                child: movieName.isEmpty
                    ? Consumer<MovieProvider>(
                        builder: (context, provider, child) {
                          return SearchResultsList(
                            moviesList: provider.trendingMoviesList,
                          );
                        },
                      )
                    : SearchResultsList(moviesList: searchMoviesList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
