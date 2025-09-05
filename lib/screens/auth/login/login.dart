import 'package:flutter/material.dart';
import 'package:movie/utilities/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../user_dm/user_model.dart';
import '../../../utilities/app_assets.dart';
import '../../../utilities/app_colors.dart';
import '../../../widgets/app_elevation_bottom.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/google_elevation_bottom.dart';
import '../../../widgets/toggle.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;

  void handleLogin() async {
    setState(() => isLoading = true);
    try {
      final user = await authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pushReplacement(context, AppRoutes.home(user));

    } catch (e) {
      print("Login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed, please try again")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 50),
            child: Image(image: AssetImage(AppAssets.logo)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppTextFormField(
                    prefixIcon: AppAssets.emailIc,
                    type: "Email",
                    controller: emailController,
                ),
                AppTextFormField(
                  type: "Password",
                  prefixIcon: AppAssets.passPostIc,
                  suffixIcon: AppAssets.passIc,
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 10,),
                isLoading
                    ? const CircularProgressIndicator(color: AppColor.yellow)
                    : AppElevationBottom(
                  type: "Login",
                  onPressed: handleLogin,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, AppRoutes.forgetPassword);
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColor.yellow,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColor.yellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ), // Forget Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Don't Have Account? ",
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
                              Navigator.push(context, AppRoutes.register);
                            },
                            child: Text(
                              "Create One",
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
                ), //Create Account
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Divider(color: AppColor.yellow, indent: 26, endIndent: 16,)),
                      Text("OR",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColor.yellow),
                        ),
                      Expanded(child: Divider(color: AppColor.yellow, indent: 16, endIndent: 26,)),
                    ],
                  ),
                ), // OR
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: GoogleElevationBottom(type: "Login With Google", textColor: AppColor.black, prefixIcon: AppAssets.googleIc,),
                ), // Login with Google
                LanguageToggle(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
