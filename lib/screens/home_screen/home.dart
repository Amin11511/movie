import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/cubit/search_cubit.dart';
import 'package:movie/screens/home_screen/tabs/browse_tab/browse_tab.dart';
import 'package:movie/screens/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movie/screens/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:movie/screens/home_screen/tabs/search_tab/search_tab.dart';
import 'package:movie/services/movies_service.dart';
import '../../user_dm/user_model.dart';
import '../../utilities/app_assets.dart';
import '../../utilities/app_colors.dart';

class Home extends StatefulWidget {
  final UserDm user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  List<Widget> get tabs => [
  HomeTab(),
  BlocProvider(
    create: (_) => SearchCubit(MoviesService()),
    child: SearchTab(),
  ),
  BrowseTab(),
  ProfileTab(user: widget.user),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: Column(
        children: [
          Expanded(child: tabs[selectedIndex]),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppColor.grey,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.yellow,
      unselectedItemColor: AppColor.white,
      iconSize: 30,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(AppAssets.homeIc, selectedIndex == 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(AppAssets.searchIc, selectedIndex == 1),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(AppAssets.browseIc, selectedIndex == 2),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(AppAssets.profileIc, selectedIndex == 3),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget buildBottomNavigationBarIcon(String icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.transparent : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ImageIcon(AssetImage(icon)),
    );
  }
}