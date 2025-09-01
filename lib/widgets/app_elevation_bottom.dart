import 'package:flutter/material.dart';
import 'package:movie/utilities/app_routes.dart';
import '../utilities/app_colors.dart';

class AppElevationBottom extends StatelessWidget {
  const AppElevationBottom({super.key, required this.type, this.color, this.textColor, this.prefixIcon});

  final String type;
  final Color? color;
  final Color? textColor;
  final String? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, AppRoutes.home);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColor.yellow,
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: AppColor.black, width: 2)),
          elevation: 0,),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)
              Image(
                image: AssetImage(prefixIcon!),
                width: 24,
                height: 24,
              ),
            const SizedBox(width: 8),
            Text(
              type,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: textColor ?? AppColor.black),
            ),
          ],
        ),
      ),
    );
  }
}
