import 'package:flutter/material.dart';
import 'package:movie/utilities/app_colors.dart';
import '../../../../movies_dm/movi_model.dart';
import '../../../../services/movies_service.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final MoviesService _service = MoviesService();
  String selectedGenre = "Action";

  final List<String> genres = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Drama",
    "Fantasy",
    "Horror",
    "Mystery",
    "Romance",
    "Sci-Fi",
    "Thriller",
  ];

  late Future<List<MovieModel>> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = _service.fetchMovies(genre: selectedGenre);
  }

  void _onGenreSelected(String genre) {
    setState(() {
      selectedGenre = genre;
      moviesFuture = _service.fetchMovies(genre: genre);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Column(
          children: [
            // Genres Chips
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              height: MediaQuery.of(context).size.height * 0.07,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  final isSelected = genre == selectedGenre;
                  return GestureDetector(
                    onTap: () => _onGenreSelected(genre),
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColor.yellow : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColor.yellow),
                      ),
                      child: Text(
                        genre,
                        style: TextStyle(
                          fontSize: 24,
                          color: isSelected ? AppColor.black : AppColor.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        
            // Movies Grid
            Expanded(
              child: FutureBuilder<List<MovieModel>>(
                future: moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.amber));
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No movies found"));
                  }
        
                  final movies = snapshot.data!;
        
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: movies.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[900],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Image.network(
                                movie.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        movie.rating.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
