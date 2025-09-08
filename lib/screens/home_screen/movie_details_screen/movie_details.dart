import 'package:flutter/material.dart';
import 'package:movie/utilities/app_assets.dart';
import 'package:movie/utilities/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../movie_details_dm/movie_details_dm.dart';
import '../../../services/favorite_service.dart';
import '../../../services/movie_details_service.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;
  const MovieDetails({super.key, required this.movieId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  bool isFavorite = false;

  Future<MovieDetailsDm> fetchMovieDetails() async {
    final service = MovieDetailsService();
    return await service.getMovieDetails(widget.movieId);
  }

  Future<void> toggleFavorite(MovieDetailsData movie) async {
    final service = FavoriteService();

    // جلب التوكين للتأكد من تسجيل الدخول
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يجب تسجيل الدخول أولاً")),
      );
      return;
    }

    bool success = false;

    if (isFavorite) {
      // ✅ إزالة من المفضلة باستخدام DELETE API الجديد
      success = await service.removeFromFavorite(movie.id.toString());
      if (success) {
        setState(() => isFavorite = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تمت الإزالة من المفضلة")),
        );
      }
    } else {
      // ❤️ إضافة إلى المفضلة كما كانت
      success = await service.addToFavorite(movie);
      if (success) {
        setState(() => isFavorite = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تمت الإضافة إلى المفضلة")),
        );
      }
    }

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("فشل في العملية")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<MovieDetailsDm>(
        future: fetchMovieDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Movie not found"));
          }

          final movie = snapshot.data!.movie;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: screenHeight * (2 / 3),
                      width: double.infinity,
                      child: Image.network(
                        movie.largeCoverImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * (2 / 3),
                      width: double.infinity,
                      child: Image.asset(
                        AppAssets.movieBg2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back_ios,
                                color: AppColor.white),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await toggleFavorite(movie);
                            },
                            child: Icon(
                              Icons.favorite,
                              color: isFavorite ? Colors.red : AppColor.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * (2 / 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // أيقونة pause أو poster overlay
                          Image(image: AssetImage(AppAssets.pause)),

                          // عنوان الفيلم
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          // سنة الإصدار
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Center(
                              child: Text(
                                movie.year.toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ), //poster
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: AppColor.red, width: 2),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Watch",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white),
                        ),
                      ],
                    ),
                  ),
                ), //elevation bottom watch
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.grey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(AppAssets.love)),
                                SizedBox(width: 16,),
                                Text(movie.likeCount.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColor.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.grey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(AppAssets.time)),
                                SizedBox(width: 16,),
                                Text(movie.runtime.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColor.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.grey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(AppAssets.star)),
                                SizedBox(width: 16,),
                                Text("0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColor.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // 3 tabs of likes, time , star
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Screenshots", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                    ],
                  ),
                ), // screenshots text
                const SizedBox(height: 16,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(movie.backgroundImageOriginal),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(movie.backgroundImageOriginal),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(movie.backgroundImageOriginal),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                  ],
                ), // 3 image of screenshots
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Similar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                    ],
                  ),
                ), // similar text
                FutureBuilder<List<dynamic>>(
                  future: MovieDetailsService().getMovieSuggestions(widget.movieId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No suggestions found"));
                    }

                    final suggestions = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: suggestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: (MediaQuery.of(context).size.width / 2) / (screenHeight / 3),
                        ),
                        itemBuilder: (context, index) {
                          final movie = suggestions[index];
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(movie["medium_cover_image"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie["rating"].toString(),
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
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Summary", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                    ],
                  ),
                ), // Summary text
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    (movie.descriptionFull != null && movie.descriptionFull!.isNotEmpty)
                        ? movie.descriptionFull!
                        : "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColor.white,
                    ),
                  )
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Text(
                        "Cast",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(image: AssetImage(AppAssets.profileIc), width: 25, height: 25, fit: BoxFit.contain,),
                          ),
                          title: Text(
                            "Name : Actor",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Character : Character",
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Text(
                        "Genres",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 10,
                    children: movie.genres.map((genre) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 3 - 32,
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColor.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
    );
  }
}