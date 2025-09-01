import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../utilities/app_assets.dart';
import '../../../utilities/app_colors.dart';
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

  final List<String> avatars = [
    AppAssets.avatarLeft,
    AppAssets.avatarMeddle,
    AppAssets.avatarRight,
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: AppColor.yellow,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
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
                  SizedBox(width: 48),
                ],
              ),
            ),
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
                          radius: isSelected
                              ? height *
                                    0.09 //
                              : height * 0.06,
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
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Avatar", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColor.white),)
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppTextFormField(
                    prefixIcon: AppAssets.usernameIc,
                    type: "Name",
                  ),
                  AppTextFormField(
                    type: "Email",
                    prefixIcon: AppAssets.emailIc,
                  ),
                  AppTextFormField(
                    type: "Password",
                    prefixIcon: AppAssets.passIc,
                    suffixIcon: AppAssets.passPostIc,
                  ),
                  AppTextFormField(
                    type: "Confirm Password",
                    prefixIcon: AppAssets.passIc,
                    suffixIcon: AppAssets.passPostIc,
                  ),
                  AppTextFormField(
                    prefixIcon: AppAssets.phoneIc,
                    type: "Phone Number",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: AppElevationBottom(type: "Create Account"),
                  ), // Create Account Bottom
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Already Have Account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: AppColor.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.yellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  LanguageToggle(), //Back to Login
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
