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

  Future<void> handleLogin() async {
    setState(() => isLoading = true);
    try {
      final UserDm user = await authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      // لو وصلنا هنا يبقى التوكين اتخزن في SharedPreferences من جوه AuthService
      debugPrint("User logged in: ${user.email}, token: ${user.token}");

      Navigator.pushReplacement(context, AppRoutes.home(user));
    } catch (e) {
      debugPrint("Login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed, please try again")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 50),
              child: const Image(image: AssetImage(AppAssets.logo)),
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
                  const SizedBox(height: 10),
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
                              fontSize: MediaQuery.of(context).size.width * 0.05,
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
                        Text(
                          "Don't Have Account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: AppColor.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, AppRoutes.register);
                          },
                          child: Text(
                            "Create One",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: AppColor.yellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), //Create Account
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                            child: Divider(
                              color: AppColor.yellow,
                              indent: 26,
                              endIndent: 16,
                            )),
                        Text(
                          "OR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: AppColor.yellow,
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                              color: AppColor.yellow,
                              indent: 16,
                              endIndent: 26,
                            )),
                      ],
                    ),
                  ), // OR
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: GoogleElevationBottom(
                      type: "Login With Google",
                      textColor: AppColor.black,
                      prefixIcon: AppAssets.googleIc,
                    ),
                  ), // Login with Google
                  const LanguageToggle(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}