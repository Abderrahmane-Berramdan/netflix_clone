import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/screens/movie_detail_screen.dart';
import 'package:netflix_clone/widgets/custom_button1.dart';
import 'package:netflix_clone/widgets/custom_button2.dart';
import 'package:netflix_clone/widgets/movie_categorie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    MovieProvider provider = context.read<MovieProvider>();
    provider.fetchNowPlayingMovies();
    provider.fetchTrendingMovies();
    provider.fetchPopularTvShows();
    provider.fetchUpcomingMovies();
    provider.fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: black,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/logo.png", height: 100, width: 100),
                      SizedBox(
                        width: 111,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.search, color: white, size: 30),
                            Icon(Icons.download, color: white, size: 30),
                            Icon(Icons.cast, color: white, size: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12,
                      children: [
                        CustomButton1(text: "Tv Shows"),
                        CustomButton1(text: "Movies"),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(color: white),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Categories",
                                style: TextStyle(fontSize: 15, color: white),
                              ),
                              PopupMenuButton(
                                color: Colors.black45,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: white,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    padding: EdgeInsets.only(
                                      top: 50,
                                      left: 10,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      "Trending Movies on Netflix",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  PopupMenuItem(
                                    child: Text(
                                      "Popular TV Series - Most - Watch For You",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: Text(
                                      "Upcoming Movies",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: Text(
                                      "Top Rated Movies",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  Center(child: CircularProgressIndicator(color: white)),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
                        itemCount: provider.nowPlayingMoviesList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                    movieModel:
                                        provider.nowPlayingMoviesList[index],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(20),
                                child:
                                    provider
                                        .nowPlayingMoviesList[index]
                                        .posterPath
                                        .isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/original${provider.nowPlayingMoviesList[index].posterPath}",
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            color: white,
                                          ),
                                        ),
                                        fit: BoxFit.fill,
                                      )
                                    : Icon(Icons.photo_size_select_actual),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: -25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          spacing: 15,
                          children: [
                            CustomButton2(
                              text: "Play",
                              icon: Icons.play_arrow,
                              color: black,
                              backgroundColor: white,
                            ),
                            CustomButton2(
                              text: "My List",
                              icon: Icons.add,
                              color: white,
                              backgroundColor: Colors.grey[800],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                MovieCategories(
                  categorieName: "Trending Movies on Netflix",
                  isLoading: provider.isLoading,
                  categorie: provider.trendingMoviesList,
                ),
                SizedBox(height: 15),
                MovieCategories(
                  categorieName: "Popular TV Series - Most - Watch For You",
                  isLoading: provider.isLoading,
                  categorie: provider.popularTvShowsList,
                ),
                SizedBox(height: 15),
                MovieCategories(
                  categorieName: "Upcoming Movies",
                  isLoading: provider.isLoading,
                  categorie: provider.upcomingMoviesList,
                ),
                SizedBox(height: 15),
                MovieCategories(
                  categorieName: "Top Rated Movies",
                  isLoading: provider.isLoading,
                  categorie: provider.topRatedMoviesList,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
