import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/models/movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movieModel;
  const MovieDetailScreen({super.key, required this.movieModel});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 350,
                child:
                    widget.movieModel.posterPath.isNotEmpty ||
                        widget.movieModel.posterPath.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${widget.movieModel.backdropPath.isEmpty ? widget.movieModel.posterPath : widget.movieModel.backdropPath}",
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
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black54,
                          ),
                          child: Icon(
                            Icons.close_outlined,
                            color: white,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black54,
                        ),
                        child: Icon(Icons.cast, color: white, size: 30),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(Icons.play_circle_outline_outlined, color: white, size: 50),
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
                    widget.movieModel.title,
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 35, child: Image.asset("assets/netflix.png")),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 20,
              children: [
                Text(widget.movieModel.releaseDate.isNotEmpty?
                  DateFormat('yyyy').format(
                    DateFormat('y').parse(widget.movieModel.releaseDate),
                  ):"",
                  style: TextStyle(color: white, fontSize: 17),
                ),
                Text("HD", style: TextStyle(color: Colors.grey, fontSize: 17)),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              widget.movieModel.overview,
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
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
