import 'package:flutter/material.dart';
import 'package:movie/utilities/app_routes.dart';
import '../../utilities/app_assets.dart';
import '../../utilities/app_colors.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<String> images = [
    AppAssets.onBoarding3,
    AppAssets.onBoarding4,
    AppAssets.onBoarding5,
    AppAssets.onBoarding6,
  ];

  final List<String> imagesGradiant = [
    AppAssets.gradiant3,
    AppAssets.gradiant4,
    AppAssets.gradiant5,
    AppAssets.gradiant6,
  ];

  final List<String> texts1 = [
    "Explore All Genres",
    "Create Watchlists",
    "Rate, Review, and Learn",
    "Start Watching Now",
  ];

  final List<String> texts2 = [
    "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    "",
  ];
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Stack(
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
                            MediaQuery.of(context).size.height *
                            0.85, // 80% من طول الشاشة
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagesGradiant[index]),
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
                          color: AppColor.black,
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
                                  texts1[index],
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.07,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (texts2[index].isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  texts2[index],
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.05,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (currentIndex < images.length - 1) {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Navigator.push(context, AppRoutes.login);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                    backgroundColor: AppColor.yellow, // اللون الأصفر
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16), // الحواف راوندد 16
                                    ),
                                  ),
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              // زرار Back يظهر بس لو currentIndex > 0
                              if (currentIndex > 0)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50),
                                      backgroundColor: AppColor.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(
                                          color: AppColor.yellow,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Back",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
