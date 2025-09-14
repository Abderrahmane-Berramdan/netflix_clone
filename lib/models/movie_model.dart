class MovieModel {
  final String title;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;

  MovieModel({
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json["title"],
      overview: json["overview"],
      backdropPath: json["backdrop_path"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      voteAverage: json["vote_average"],
    );
  }
}

/*

    "results": [
        {
            "adult": false,
            "backdrop_path": "/1RgPyOhN4DRs225BGTlHJqCudII.jpg",
            "genre_ids": [
                16,
                28,
                14,
                53
            ],
            "id": 1311031,
            "original_language": "ja",
            "original_title": "劇場版「鬼滅の刃」無限城編 第一章 猗窩座再来",
            "overview": "The Demon Slayer Corps are drawn into the Infinity Castle, where Tanjiro, Nezuko, and the Hashira face terrifying Upper Rank demons in a desperate fight as the final battle against Muzan Kibutsuji begins.",
            "popularity": 695.2696,
            "poster_path": "/aFRDH3P7TX61FVGpaLhKr6QiOC1.jpg",
            "release_date": "2025-07-18",
            "title": "Demon Slayer: Kimetsu no Yaiba Infinity Castle",
            "video": false,
            "vote_average": 7.619,
            "vote_count": 159
        },
    ]

 */
