import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/cubit/movies_cubit.dart';
import '../../../../utilities/app_assets.dart';
import '../../../../utilities/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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

            final genresSet = <String>{};
            for (var movie in movies) {
              genresSet.addAll(movie.genres);
            }
            final genres = genresSet.toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Background + Carousel =====
                  SizedBox(
                    height: screenHeight * 2 / 3,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(AppAssets.bg3, fit: BoxFit.contain),
                        Image.asset(AppAssets.bg1, fit: BoxFit.contain),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Expanded(
                              child: Image.asset(
                                AppAssets.bg2,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),

                        // Carousel فوق الخلفية
                        Align(
                          alignment: Alignment.center,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: screenHeight * 0.35,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 0.6,
                            ),
                            items: movies.map((movie) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          color: Colors.grey[200],
                                          child: Image.network(
                                            movie.image,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  movie.rating.toString(),
                                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                                ),
                                                const SizedBox(width: 4),
                                                const Icon(Icons.star, color: Colors.yellow, size: 16),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== Sections by Genre =====
                  ...genres.map((genre) {
                    final genreMovies = movies
                        .where((movie) => movie.genres.contains(genre))
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                genre,
                                style: const TextStyle(
                                  color: AppColor.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "See More",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColor.yellow,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColor.yellow,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: 220,
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
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: Image.network(
                                                movie.image,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              left: 8,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withOpacity(0.7),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      movie.rating.toString(),
                                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        movie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: AppColor.white),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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


