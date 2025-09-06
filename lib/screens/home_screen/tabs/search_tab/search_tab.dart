import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/cubit/search_cubit.dart';
import 'package:movie/movies_dm/movi_model.dart';
import 'package:movie/utilities/app_assets.dart';
import 'package:movie/utilities/app_colors.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Column(
          children: [
            // حقل البحث
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.done,
                cursorColor: AppColor.yellow,
                decoration: InputDecoration(
                  hintText: "Search movies...",
                  hintStyle: const TextStyle(color: AppColor.white),
                  filled: true,
                  fillColor: AppColor.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColor.grey, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColor.yellow, width: 2),
                  ),
                  prefixIcon: Image(image: AssetImage(AppAssets.searchIc), color: AppColor.white, height: 24, width: 24,),
                ),
                onChanged: (query) {
                  searchCubit.searchMovies(query);
                },
              ),
            ),

            // عرض النتائج
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Center(
                      child: Image.asset(AppAssets.empty),
                    );
                  } else if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.yellow),
                    );
                  } else if (state is SearchLoaded) {
                    final movies = state.movies;
                    if (movies.isEmpty) {
                      return Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }

                    final screenHeight = MediaQuery.of(context).size.height;
                    final screenWidth = MediaQuery.of(context).size.width;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: GridView.builder(
                        itemCount: movies.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: (screenWidth / 2) / (screenHeight / 3),
                        ),
                        itemBuilder: (context, index) {
                          final MovieModel movie = movies[index];
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(movie.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie.rating.toString(),
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
