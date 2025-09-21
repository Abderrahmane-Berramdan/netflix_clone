import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/screens/movie_detail_screen.dart';

class MovieCategories extends StatelessWidget {
  final String categorieName;
  final bool isLoading;
  final List<MovieModel> categorie;

  const MovieCategories({
    super.key,
    required this.categorieName,
    required this.isLoading,
    required this.categorie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text(
          categorieName,
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),

        SizedBox(
          height: 200,
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: white))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categorie.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movieModel: categorie[index]),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 200,
                        width: 150,
                        child: categorie[index].posterPath.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/original${categorie[index].posterPath}",
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: white,
                                  ),
                                ),
                                fit: BoxFit.fill,
                              )
                            : Icon(Icons.photo_size_select_actual),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
