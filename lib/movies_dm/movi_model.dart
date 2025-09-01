class MovieModel {
  final int id;
  final String title;
  final int year;
  final double rating;
  final String image;
  final List<String> genres;

  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.image,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      image: json['medium_cover_image'] ?? '',
      genres: json['genres'] != null
          ? List<String>.from(json['genres'])
          : [],
    );
  }
}
