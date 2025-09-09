import 'package:flutter/material.dart';
import '../utilities/app_assets.dart';
import '../utilities/app_colors.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  List<bool> isSelected = [true, false]; // [EN, AR]

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.yellow), // مش مهم
        borderRadius: BorderRadius.circular(50),
      ),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(50),
        isSelected: isSelected,
        onPressed: (index) {
          setState(() {
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }
          });
          // print(index == 0 ? "English selected" : "Arabic selected");
        },
        renderBorder: false, // نخليه إحنا manually
        fillColor: Colors.transparent,
        constraints: const BoxConstraints(minWidth: 50, minHeight: 40),
        children: List.generate(2, (index) {
          final isActive = isSelected[index];
          final imagePath = index == 0 ? AppAssets.en : AppAssets.ar;

          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                color: isActive ? AppColor.yellow : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(
              imagePath,
              width: 27,
              height: 27,
              fit: BoxFit.contain,
            ),
          );
        }),
      ),
    );
  }
}