import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/services/movie_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieModel> movielist = [];
  bool isLoading = false;

  void fetchMovie() async {
    setState(() {
      isLoading = true;
    });
    final response = await MovieApi.fetchMovie();
    setState(() {
      movielist = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
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
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: white),
                      ),
                      child: Text(
                        "Tv Shows",
                        style: TextStyle(fontSize: 15, color: white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: white),
                      ),
                      child: Text(
                        "Movies",
                        style: TextStyle(fontSize: 15, color: white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: white),
                      ),
                      child: Text(
                        "Categories",
                        style: TextStyle(fontSize: 15, color: white),
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
                    itemCount: movielist.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original${movielist[index].posterPath}",
                          fit: BoxFit.fill,
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
                        Container(
                          width: 150,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow),
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
                          width: 150,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: white),
                              Text(
                                "My List",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "Trending Movies on Netflix",
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 200,
              child: isLoading
                  ? Center(child: CircularProgressIndicator(color: white))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movielist.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 200,
                          width: 170,
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original${movielist[index].posterPath}",
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
