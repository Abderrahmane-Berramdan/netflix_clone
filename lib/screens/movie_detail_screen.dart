import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/models/movie_detail_model.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/services/movie_api.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movieModel;
  const MovieDetailScreen({super.key, required this.movieModel});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailModel? movieDetail;
  bool isLoading = false;

  Future<void> fetchMovieDetail(int id) async {
    setState(() {
      isLoading = true;
    });
    final response = await MovieApi.fetchMovieDetail(id);
    setState(() {
      movieDetail = response;
      isLoading = false;
    });
  }

  String formatRunTime(int runTime) {
    if (runTime <= 0) {
      return "0h 0m";
    }

    int hours = runTime ~/ 60;
    int minutes = runTime % 60;

    return "${hours}h ${minutes}m";
  }

  @override
  void initState() {
    super.initState();
    fetchMovieDetail(widget.movieModel.id);
  }

  @override
  Widget build(BuildContext context) {
    String genresText = "";
    if (movieDetail != null) {
      genresText = movieDetail!.genres.map((genre) => genre.name).join(" | ");
    }

    return Scaffold(
      backgroundColor: black,
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: white))
          : movieDetail == null
          ? Center(
              child: Text(
                "No Movie Detaile For This Movie",
                style: TextStyle(color: white, fontSize: 20),
              ),
            )
          : ListView(
              padding: EdgeInsets.only(top: 0),
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 350,
                      child:
                          movieDetail!.posterPath.isNotEmpty ||
                              movieDetail!.posterPath.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl:
                                  "https://image.tmdb.org/t/p/original${movieDetail!.backdropPath.isEmpty ? movieDetail!.posterPath : movieDetail!.backdropPath}",
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(color: white),
                              ),
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.photo_size_select_actual,
                              size: 200,
                              color: Colors.grey,
                            ),
                    ),
                    Positioned(
                      right: 10,
                      top: 30,
                      child: SizedBox(
                        width: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: Icon(
                                  Icons.close_outlined,
                                  color: white,
                                  size: 30,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: Icon(Icons.cast, color: white, size: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.play_circle_outline_outlined,
                      color: white,
                      size: 50,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movieDetail!.title,
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        child: Image.asset("assets/netflix.png"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    spacing: 20,
                    children: [
                      Text(
                        movieDetail!.releaseDate.isNotEmpty
                            ? DateFormat('yyyy').format(
                                DateFormat('y').parse(movieDetail!.releaseDate),
                              )
                            : "",
                        style: TextStyle(color: white, fontSize: 17),
                      ),
                      Text(
                        formatRunTime(movieDetail!.runTime),
                        style: TextStyle(color: white, fontSize: 17),
                      ),
                      Text(
                        "HD",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, size: 30),
                      Text(
                        "Play",
                        style: TextStyle(
                          color: black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.download, color: white, size: 30),
                      Text(
                        "Download",
                        style: TextStyle(
                          color: white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      genresText,
                      style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    movieDetail!.overview,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.add, color: white, size: 40),
                          Text(
                            "My List",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Iconsax.like_15, color: white, size: 40),
                          Text(
                            "Rate",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.share, color: white, size: 40),
                          Text(
                            "Share",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
    );
  }
}
