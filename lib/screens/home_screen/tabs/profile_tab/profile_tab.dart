import 'package:flutter/material.dart';
import 'package:movie/utilities/app_assets.dart';
import 'package:movie/utilities/app_colors.dart';
import 'package:movie/utilities/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../favorites_dm/favorites_movie_dm.dart';
import '../../../../services/favorite_service.dart';
import '../../../../services/profile_service.dart';
import '../../../../user_dm/user_model.dart';

class ProfileTab extends StatefulWidget {
  final UserDm? user;
  const ProfileTab({super.key, required this.user});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late Future<UserDm> _futureProfile;
  int selectedIndex = 0;
  late Future<List<FavoriteMovieDm>> _futureFavorites;
  int favoriteCount = 0;

  @override
  void initState() {
    super.initState();
    _futureProfile = _loadProfile();
    _futureFavorites = FavoriteService().getAllFavorites();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final favorites = await FavoriteService().getAllFavorites();
    setState(() {
      favoriteCount = favorites.length;
    });
  }

  Future<UserDm> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("No token found");
    return ProfileService().getProfile(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserDm>(
        future: _futureProfile,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // Data loaded
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 35,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(image: AssetImage(AppAssets.avatar), width: 120, height: 120,),
                                      SizedBox(height: 15),
                                      Text(
                                        user.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(favoriteCount.toString(), style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColor.white),),
                                      SizedBox(height: 20),
                                      Text("Wish List", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("10", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColor.white),),
                                      SizedBox(height: 20),
                                      Text("History", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 60,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(context, AppRoutes.updateProfile());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.yellow,
                                      foregroundColor: Colors.black,
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: AppColor.black, width: 2)),
                                      elevation: 0,
                                    ),
                                    child: Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  flex: 40,
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.red,
                                      foregroundColor: Colors.black,
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: AppColor.black, width: 2)),
                                      elevation: 0,
                                    ),
                                    child: Image(image: AssetImage(AppAssets.exit)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: selectedIndex == 0 ? AppColor.yellow : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image(image: AssetImage(AppAssets.list)),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Watch List",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: AppColor.white,
                                            ),
                                          ),
                                          SizedBox(height: 16,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: selectedIndex == 1 ? AppColor.yellow : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image(image: AssetImage(AppAssets.history)),
                                          const SizedBox(height: 10),
                                          Text(
                                            "History",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: AppColor.white,
                                            ),
                                          ),
                                          SizedBox(height: 16,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<FavoriteMovieDm>>(
                    future: FavoriteService().getAllFavorites(), // ✅ هنا الداتا
                    builder: (context, favSnapshot) {
                      if (favSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (favSnapshot.hasError) {
                        return Center(child: Text("Error: ${favSnapshot.error}"));
                      }

                      final favorites = favSnapshot.data ?? [];

                      if (favorites.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(AppAssets.empty),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: favorites.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) {
                            final movie = favorites[index];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(movie.imageURL),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            movie.rating.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text("No user data"));
        },
      ),
    );
  }
}