import 'package:flutter/material.dart';
import 'package:movie/user_dm/user_model.dart';
import 'package:movie/utilities/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/profile_service.dart';
import '../../../utilities/app_assets.dart';
import '../../../utilities/app_colors.dart';
import '../../auth/forget_password/forget_password.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late Future<UserDm> _futureUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final List<String> avatars = [
    AppAssets.avatarLeft,
    AppAssets.avatarMeddle,
    AppAssets.avatarRight,
    AppAssets.avatar4,
    AppAssets.avatar5,
    AppAssets.avatar6,
    AppAssets.avatar7,
    AppAssets.avatar8,
    AppAssets.avatar9,
  ];

  int? selectedAvatarIndex;

  @override
  void initState() {
    super.initState();
    _futureUser = _loadUser();
  }

  Future<UserDm> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) throw Exception("No token found");
    final user = await ProfileService().getProfile(token);
    // تعيين القيم الأولية للـ controllers هنا بدلًا من داخل الـ build
    _nameController.text = user.name ?? "";
    _phoneController.text = user.phone ?? "";
    return user;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> handleUpdateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No token found")),
      );
      return;
    }

    try {
      final currentUser = await _futureUser;
      final int avaterToSend = selectedAvatarIndex ?? currentUser.avaterId ?? 0;
      final String nameToSend = _nameController.text; // إرسال الاسم حتى لو فاضي
      final String phoneToSend = _phoneController.text; // إرسال الموبايل حتى لو فاضي
      print('Sending data: name: $nameToSend, phone: $phoneToSend, avaterId: $avaterToSend'); // للتصحيح

      final message = await ProfileService().updateProfile(
        token: token,
        name: nameToSend,
        phone: phoneToSend,
        avaterId: avaterToSend,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      print('Returning data: ${{
        'name': nameToSend,
        'phone': phoneToSend,
        'avaterId': avaterToSend,
      }}'); // للتصحيح

      // Return updated data as a map
      Navigator.pop(context, {
        'name': nameToSend,
        'phone': phoneToSend,
        'avaterId': avaterToSend,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Update failed: $e")),
      );
    }
  }

  void _handleDeleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No token found")),
      );
      return;
    }

    try {
      final message = await ProfileService().deleteAccount(token);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      Navigator.pushReplacement(context, AppRoutes.login);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.grey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                final bool isSelected = index == selectedAvatarIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatarIndex = index;
                    });
                    setModalState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColor.yellow,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        avatars[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: FutureBuilder<UserDm>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColor.yellow));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No user data", style: TextStyle(color: Colors.white)));
          }

          return SingleChildScrollView(
            child: Column(
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
                GestureDetector(
                  onTap: () {
                    _showAvatarPicker(context);
                  },
                  child: Image(
                    image: AssetImage(avatars[selectedAvatarIndex ?? snapshot.data!.avaterId ?? 0]),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
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
                          image: AssetImage(AppAssets.name),
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
                          image: AssetImage(AppAssets.phoneIc),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ForgetPassword()),
                          );
                        },
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: _handleDeleteAccount,
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
                    onPressed: handleUpdateProfile,
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
            ),
          );
        },
      ),
    );
  }
}
