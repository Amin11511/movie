import 'package:flutter/material.dart';
import 'package:movie/widgets/app_text_form_field.dart';
import '../../../utilities/app_assets.dart';
import '../../../utilities/app_colors.dart';
import '../../../widgets/app_elevation_bottom.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Column(
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
                      "Forget Password",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Image(image: AssetImage(AppAssets.forgetPassword), fit: BoxFit.fill,),
                ),
                AppTextFormField(prefixIcon: AppAssets.emailIc, type: "Email"),
                SizedBox(height: 16),
                AppElevationBottom(type: "Verify Email"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
