import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/auth_service.dart';
import '../../../user_dm/user_model.dart';
import '../../../utilities/app_assets.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_routes.dart';
import '../../../widgets/app_elevation_bottom.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/toggle.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int _currentIndex = 1;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final AuthService authService = AuthService();

  final List<String> avatars = [
    AppAssets.avatarLeft,
    AppAssets.avatarMeddle,
    AppAssets.avatarRight,
  ];

  bool isLoading = false;

  void handleRegister() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // 1️⃣ عمل تسجيل أولاً
      await authService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        phone: phoneController.text,
        avaterId: _currentIndex,
      );

      print("User registered successfully");

      // 2️⃣ فوراً بعد التسجيل، اعمل login
      UserDm user = await authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      print("User logged in: ${user.name}, email: ${user.email}, token: ${user.token}");

      // 3️⃣ حفظ الـ token في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", user.token!);

      // 4️⃣ الانتقال للشاشة الرئيسية
      Navigator.pushReplacement(
        context,
        AppRoutes.home(user),
      );

    } catch (e) {
      print("Register/Login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Register failed")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
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
                        "Register",
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
            // Avatar carousel
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: CarouselSlider.builder(
                    itemCount: avatars.length,
                    itemBuilder: (context, index, realIndex) {
                      bool isSelected = index == _currentIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(avatars[index]),
                          radius: isSelected ? height * 0.09 : height * 0.06,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: height * 0.18,
                      enlargeCenterPage: true,
                      initialPage: _currentIndex,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.4,
                      onPageChanged: (index, reason) {
                        setState(() => _currentIndex = index);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text("Avatar",
                    style: TextStyle(fontSize: 16, color: AppColor.white)),
              ],
            ),
            // Form fields
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppTextFormField(
                    prefixIcon: AppAssets.usernameIc,
                    type: "Name",
                    controller: nameController,
                  ),
                  AppTextFormField(
                    prefixIcon: AppAssets.emailIc,
                    type: "Email",
                    controller: emailController,
                  ),
                  AppTextFormField(
                    prefixIcon: AppAssets.passIc,
                    suffixIcon: AppAssets.passPostIc,
                    type: "Password",
                    controller: passwordController,
                  ),
                  AppTextFormField(
                    prefixIcon: AppAssets.passIc,
                    suffixIcon: AppAssets.passPostIc,
                    type: "Confirm Password",
                    controller: confirmPasswordController,
                  ),
                  AppTextFormField(
                    prefixIcon: AppAssets.phoneIc,
                    type: "Phone Number",
                    controller: phoneController,
                  ),
                  // Create Account Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : AppElevationBottom(
                      type: "Create Account",
                      onPressed: handleRegister,
                    ),
                  ),

                  // Login link
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already Have Account? ",
                            style:
                            TextStyle(fontSize: 14, color: AppColor.white)),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text("Login",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.yellow)),
                        ),
                      ],
                    ),
                  ),

                  // Language Toggle
                  LanguageToggle(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
