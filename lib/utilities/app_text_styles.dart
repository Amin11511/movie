import 'dart:ui';
import 'app_colors.dart';

abstract class AppTextStyle {
  static final TextStyle white36 = TextStyle(color: AppColor.white, fontSize: 36, fontWeight: FontWeight.w500);
  static final TextStyle white20 = TextStyle(color: AppColor.white, fontSize: 20, fontWeight: FontWeight.normal);
  static final TextStyle yellow20 = TextStyle(color: AppColor.yellow, fontSize: 20, fontWeight: FontWeight.w800);
  static final TextStyle whiteOpacity20 = TextStyle(color: AppColor.white.withOpacity(0.6), fontSize: 20, fontWeight: FontWeight.normal);
  static final TextStyle white24 = TextStyle(color: AppColor.white, fontSize: 24, fontWeight: FontWeight.bold);
  static final TextStyle black20 = TextStyle(color: AppColor.black, fontSize: 20, fontWeight: FontWeight.w800);
}