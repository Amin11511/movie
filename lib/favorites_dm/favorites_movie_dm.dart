class FavoriteMovieDm {
  final String movieId;
  final String name;
  final double rating;
  final String imageURL;
  final String year;

  FavoriteMovieDm({
    required this.movieId,
    required this.name,
    required this.rating,
    required this.imageURL,
    required this.year,
  });

  factory FavoriteMovieDm.fromJson(Map<String, dynamic> json) {
    return FavoriteMovieDm(
      movieId: json["movieId"] ?? "",
      name: json["name"] ?? "",
      rating: (json["rating"] != null) ? (json["rating"] as num).toDouble() : 0.0,
      imageURL: json["imageURL"] ?? "",
      year: json["year"] ?? "",
    );
  }
}