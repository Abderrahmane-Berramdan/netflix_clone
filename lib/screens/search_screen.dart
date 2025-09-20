import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/screens/movie_detail_screen.dart';
import 'package:netflix_clone/services/movie_api.dart';
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
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: provider.trendingMoviesList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                        movieModel:
                                            provider.trendingMoviesList[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 150,
                                        child:
                                            provider
                                                .trendingMoviesList[index]
                                                .posterPath
                                                .isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    "https://image.tmdb.org/t/p/original${provider.trendingMoviesList[index].backdropPath}",
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                            color: white,
                                                          ),
                                                    ),
                                                fit: BoxFit.cover,
                                              )
                                            : Icon(
                                                Icons.photo_size_select_actual,
                                                color: Colors.grey,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          provider
                                              .trendingMoviesList[index]
                                              .title,
                                          style: TextStyle(
                                            color: white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Icon(
                                        Icons.play_circle_outline_outlined,
                                        color: white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: searchMoviesList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                    movieModel: searchMoviesList[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child:
                                        searchMoviesList[index]
                                                .posterPath
                                                .isNotEmpty ||
                                            searchMoviesList[index]
                                                .backdropPath
                                                .isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/original${searchMoviesList[index].backdropPath.isEmpty ? searchMoviesList[index].posterPath : searchMoviesList[index].backdropPath}",
                                            placeholder: (context, url) =>
                                                Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: white,
                                                      ),
                                                ),
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.photo_size_select_actual,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      searchMoviesList[index].title,
                                      style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.play_circle_outline_outlined,
                                    color: white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
