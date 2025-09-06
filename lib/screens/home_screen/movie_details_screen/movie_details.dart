import 'package:flutter/material.dart';
import 'package:movie/utilities/app_assets.dart';
import 'package:movie/utilities/app_colors.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * (2 / 3),
                  width: double.infinity,
                  child: const Image(
                    image: AssetImage(AppAssets.movieBg1),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (2 / 3),
                  width: double.infinity,
                  child: const Image(
                    image: AssetImage(AppAssets.movieBg2),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios, color: AppColor.white,),
                      Spacer(),
                      Image(image: AssetImage(AppAssets.save)),
                      SizedBox(width: 6,),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (2 / 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image(image: AssetImage(AppAssets.pause)),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Doctor Strange in the Multiverse of Madness",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColor.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Center(child: Text("2022", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white,), textAlign: TextAlign.center,)),
                      ),
                    ],
                  ),
                ),
              ],
            ), //poster
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColor.red, width: 2),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Watch",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white),
                    ),
                  ],
                ),
              ),
            ), //elevation bottom watch
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage(AppAssets.love)),
                            SizedBox(width: 16,),
                            Text("15", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColor.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage(AppAssets.time)),
                            SizedBox(width: 16,),
                            Text("15", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColor.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage(AppAssets.star)),
                            SizedBox(width: 16,),
                            Text("15", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColor.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), // 3 tabs of likes, time , star
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Screenshots", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                ],
              ),
            ), // screenshots text
            SizedBox(height: 16,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey,
                    ),
                    child: const Placeholder(),
                  ),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey,
                    ),
                    child: const Placeholder(),
                  ),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey,
                    ),
                    child: const Placeholder(),
                  ),
                ),
                SizedBox(height: 16,),
              ],
            ), // 3 image of screenshots
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Similar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                ],
              ),
            ), // similar text
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Summary", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                ],
              ),
            ), // Summary text
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Cast", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                ],
              ),
            ), // Cast text
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Genres", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),),
                ],
              ),
            ), // genres text
            SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }
}