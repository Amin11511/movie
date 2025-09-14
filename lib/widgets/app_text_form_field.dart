import 'package:flutter/material.dart';
import '../utilities/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.type,
    required this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.validator,
  });

  final String type;
  final String prefixIcon;
  final String? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColor.yellow,
            selectionColor: AppColor.yellow.withOpacity(0.3),
            selectionHandleColor: AppColor.yellow,
          ),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          textInputAction: TextInputAction.done,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(image: AssetImage(prefixIcon), height: 24, width: 24),
            ),
            suffixIcon: suffixIcon != null
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage(suffixIcon!),
                height: 24,
                width: 24,
              ),
            )
                : null,
            hintText: type,
            hintStyle: TextStyle(
              color: AppColor.white,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
            filled: true,
            fillColor: AppColor.grey,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFF898F9C), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColor.yellow, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}