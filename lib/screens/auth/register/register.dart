import 'package:dio/dio.dart';
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
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
    AppAssets.avatar4,
    AppAssets.avatar5,
    AppAssets.avatar6,
    AppAssets.avatar7,
    AppAssets.avatar8,
    AppAssets.avatar9,
  ];

  bool isLoading = false;
  String? selectedAvatar;

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
      // Register first
      await authService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        phone: phoneController.text,
        avaterId: _currentIndex,
      );

      print("User registered successfully");

      // After register ... login
      UserDm user = await authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      print("User logged in: ${user.name}, email: ${user.email}, token: ${user.token}");

      // Save token into shared preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", user.token!);

      // Navigate into home screen
      Navigator.pushReplacement(
        context,
        AppRoutes.home(user),
      );

    } catch (e) {
      String errorMessage = "Register failed";

      if (e is DioException) {
        final rawMessage = e.response?.data["message"]?.toString() ?? "";

        final errorMap = {
          "email already exists": "Email already exists",
          "password mismatch": "Password don't match",
          "invalid phone": "Invalid Phone, try +20 before your phone",
          "email must be an email": "Email must be @etc.com",
          "password is must be strong": "Password must be strong (Capital - Small - Sign - Number)",
          "password must be longer than or equal to 8 characters": "Password must be longer than or equal to 8 characters",
          "confirm password must be strong": "Confirm password must be strong",
          "confirmpassword must be longer than or equal to 8 characters": "Confirm Password must be longer than or equal to 8 characters",
          "phone invaild": "Invalid Phone, try +20 before your phone and your phone equal 10 numbers",
        };

        errorMessage = errorMap.entries
            .firstWhere(
              (entry) => rawMessage.toLowerCase().contains(entry.key),
          orElse: () => MapEntry("", rawMessage),
        )
            .value;
      } else {
        errorMessage = "Something went wrong";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
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
                  Expanded(
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
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
                        setState(() {
                          _currentIndex = index;
                          selectedAvatar = avatars[index];
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text("Avatar",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, color: AppColor.white)),
              ],
            ),
            // Form fields
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //Name
                  AppTextFormField(
                    prefixIcon: AppAssets.usernameIc,
                    type: "Name",
                    controller: nameController,
                  ),
                  //Email
                  AppTextFormField(
                    prefixIcon: AppAssets.emailIc,
                    type: "Email",
                    controller: emailController,
                  ),
                  //password
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      AppTextFormField(
                        type: "Password",
                        prefixIcon: AppAssets.passIc,
                        controller: passwordController,
                        obscureText: _obscurePassword,
                      ),
                      IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: _obscurePassword ? AppColor.white : AppColor.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ],
                  ),
                  //Confirm Password
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      AppTextFormField(
                        type: "Password",
                        prefixIcon: AppAssets.passIc,
                        controller: confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                      ),
                      IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: _obscureConfirmPassword ? AppColor.white : AppColor.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ],
                  ),
                  //phone number
                  AppTextFormField(
                    prefixIcon: AppAssets.phoneIc,
                    type: "Phone Number",
                    controller: phoneController,
                  ),
                  // Create Account Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: isLoading
                        ? const CircularProgressIndicator(color: AppColor.yellow,)
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
                        Text("Already Have Account? ",
                            style:
                            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color: AppColor.white)),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
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
