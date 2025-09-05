import 'package:flutter/material.dart';
import 'package:movie/widgets/app_text_form_field.dart';
import '../../../services/auth_service.dart';
import '../../../utilities/app_assets.dart';
import '../../../utilities/app_colors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
    // انا مش عارف اكتب ايه هنا
    // لإن مفيش سكرينة فيها الباسورد القديم والباسورد الجديد
    // اعتقد لازم يبقى فيه API تاني للتحقق
        final response = await AuthService().resetPassword(
        token: "", // مفيش توكن في الفورجت باسورد عادة
        oldPassword: "", // لو محتاج تكتب حاجة
        newPassword: "", // أو تركها فاضية حسب API الفورجت
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                AppTextFormField(
                    controller: _emailController,
                    prefixIcon: AppAssets.emailIc,
                    type: "Email"
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _resetPassword,
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
                        "Verify Email",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
