import 'package:flutter/material.dart';
import '../../../utilities/app_assets.dart';
import '../../../utilities/app_colors.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Column(
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
          SizedBox(height: 35),
          Image(image: AssetImage(AppAssets.avatarMeddle)),
          SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
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
                hintStyle: const TextStyle(
                    color: Color(0xFF898F9C), fontSize: 18),
                filled: true,
                fillColor: AppColor.grey,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: Color(0xFF898F9C), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: AppColor.yellow, width: 2),
                ),
              ),
              style: const TextStyle(fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
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
                hintStyle: const TextStyle(
                    color: Color(0xFF898F9C), fontSize: 18),
                filled: true,
                fillColor: AppColor.grey,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: Color(0xFF898F9C), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                      color: AppColor.yellow, width: 2),
                ),
              ),
              style: const TextStyle(fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
          Spacer(),
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
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: (){},
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
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}