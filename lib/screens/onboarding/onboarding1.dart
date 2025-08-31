import 'package:flutter/material.dart';
import 'package:movie/utilities/app_assets.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_routes.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Container(
              height: MediaQuery.of(
                context,
              ).size.height, // ياخد طول الشاشة كله
              width: double.infinity,
              color:
              Colors.black, // لون للخلفية (ممكن تغيره أو تخليه شفاف)
              child: Align(
                alignment: Alignment.topCenter, // الصورة تبدأ من فوق
                child: Container(
                  height:
                  MediaQuery.of(context).size.height, // 80% من طول الشاشة
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.onBoarding1),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.gradiant1),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.20,
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: AppColor.black.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Find Your Next Favorite Movie Here",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Get access to a huge library of movies to suit all tastes. You will surely like it.",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, AppRoutes.onboarding2);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              backgroundColor: AppColor.yellow, // اللون الأصفر
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16), // الحواف راوندد 16
                              ),
                            ),
                            child: Text(
                              "Explore Now",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
