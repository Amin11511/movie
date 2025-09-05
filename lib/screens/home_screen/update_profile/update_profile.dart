import 'package:flutter/material.dart';
import 'package:movie/user_dm/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/profile_service.dart';
import '../../../utilities/app_assets.dart';
import '../../../utilities/app_colors.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late Future<UserDm> _futureUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureUser = _loadUser();
  }

  Future<UserDm> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("No token found");
    return ProfileService().getProfile(token);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: FutureBuilder<UserDm>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No user data", style: TextStyle(color: Colors.white)));
          }

          // البيانات جاهزة
          final user = snapshot.data!;
          _nameController.text = user.name ?? "";
          _phoneController.text = user.phone ?? "";

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: AppColor.yellow,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: AppColor.yellow,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Image(image: AssetImage(AppAssets.avatarMeddle)),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColor.yellow,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image(
                        image: AssetImage(AppAssets.profileIc),
                        height: 24,
                        width: 24,
                      ),
                    ),
                    hintStyle: const TextStyle(color: Color(0xFF898F9C), fontSize: 18),
                    filled: true,
                    fillColor: AppColor.grey,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF898F9C), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColor.yellow, width: 2),
                    ),
                  ),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _phoneController,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColor.yellow,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image(
                        image: AssetImage(AppAssets.profileIc),
                        height: 24,
                        width: 24,
                      ),
                    ),
                    hintStyle: const TextStyle(color: Color(0xFF898F9C), fontSize: 18),
                    filled: true,
                    fillColor: AppColor.grey,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF898F9C), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColor.yellow, width: 2),
                    ),
                  ),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
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
                        "Delete Account",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.yellow,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColor.yellow, width: 2),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Update Data",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
