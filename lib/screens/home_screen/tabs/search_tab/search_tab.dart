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
      backgroundColor: AppColor.grey,
      body: SafeArea(
        child: Column(
          children: [
            // حقل البحث
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search movies...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: AppColor.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(Icons.search, color: AppColor.yellow),
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
                    return  Center(
                      child:Image.asset(AppAssets.empty)
                    );
                  } else if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.yellow),
                    );
                  } else if (state is SearchLoaded) {
                    final movies = state.movies;
                    if (movies.isEmpty) {
                      return  Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final MovieModel movie = movies[index];
                        return ListTile(
                          leading: Image.network(
                            movie.image, // ✅ عندك اسمها image
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            movie.title, // ✅ عندك title عادي
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "${movie.year} - ⭐ ${movie.rating}", // ✅ نعرض السنة والتقييم
                            style: const TextStyle(color: Colors.white70),
                          ),
                        );
                      },
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
