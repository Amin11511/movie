import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/cubit/movies_cubit.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bannerHeight = screenHeight * 0.3; 
    final screenWidth = MediaQuery.of(context).size.width;
    final movieWidth = screenWidth * 0.3;

    return Scaffold(
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoviesLoaded) {
            final movies = state.movies;

            if (movies.isEmpty) {
              return const Center(child: Text("No movies found"));
            }

          
            final topMovie = movies.first;

        
            final genresSet = <String>{};
            for (var movie in movies) {
              genresSet.addAll(movie.genres);
            }
            final genres = genresSet.toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner
                  Stack(
                    children: [
                      Image.network(
                        topMovie.image,
                        width: double.infinity,
                        height: bannerHeight,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${topMovie.title} - Rating: ${topMovie.rating}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sections by Genre
                  ...genres.map((genre) {
                    final genreMovies =
                        movies
                            .where((movie) => movie.genres.contains(genre))
                            .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            genre,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: genreMovies.length,
                            itemBuilder: (_, index) {
                              final movie = genreMovies[index];
                              return Container(
                                width: movieWidth,
                                margin: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        movie.image,
                                        fit: BoxFit.cover,
                                        width: movieWidth,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      movie.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          } else if (state is MoviesError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
