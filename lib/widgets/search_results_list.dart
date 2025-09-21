import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/screens/movie_detail_screen.dart';

class SearchResultsList extends StatelessWidget {
  final List<MovieModel> moviesList;
  const SearchResultsList({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    if (moviesList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text('No results', style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: moviesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieDetailScreen(movieModel: moviesList[index]),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  width: 150,
                  child:
                      moviesList[index].posterPath.isNotEmpty ||
                          moviesList[index].backdropPath.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/original${moviesList[index].backdropPath.isEmpty ? moviesList[index].posterPath : moviesList[index].backdropPath}",
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(color: white),
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
                    moviesList[index].title,
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
  }
}
