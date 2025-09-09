import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

class GoogleElevationBottom extends StatelessWidget {
  const GoogleElevationBottom({super.key, required this.type, this.color, this.textColor, this.prefixIcon});

  final String type;
  final Color? color;
  final Color? textColor;
  final String? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColor.yellow,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: AppColor.yellow, width: 2)),
          elevation: 0,
        ),
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
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.normal, color: textColor ?? Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}