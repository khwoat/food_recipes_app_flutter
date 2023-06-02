import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/string.dart';
import '../constants/text_style.dart';
import '../route.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pageList = AppRoute.allPageView();

  final PageController _pageController = PageController();

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.ORANGE_FE7455,
        toolbarHeight: 70,
        title: Text(
          AppString.APP_NAME,
          textAlign: TextAlign.center,
          style: AppTextStyle.F24_BOLD.copyWith(
            color: AppColors.WHITE,
            fontFamily: "Forte",
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: const Icon(Icons.person),
              );
            },
          )
        ],
      ),
      endDrawer: _getDrawer(context),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _pageIndex = value;
                });
              },
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pageList,
            ),
          ),
          _getBottomNavigationBar(context),
        ],
      ),
    );
  }

  // End drawer for setting menu
  Widget _getDrawer(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
        child: Column(
          children: [
            // Image and username
            const Icon(
              Icons.person,
              size: 50,
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thiwakorn Srimoo",
                  style: AppTextStyle.F20_BOLD,
                ),
                Text(
                  "thiwakorn.srimo@gmail.com",
                  style: AppTextStyle.F14_NORMAL,
                ),
              ],
            ),
            const SizedBox(height: 15),
            _getDrawerMenuItem(context, label: "Setting", onTap: () {}),
            _getDrawerMenuItem(
              context,
              label: "Logout",
              onTap: () =>
                  Navigator.popAndPushNamed(context, AppRoute.LOGIN_PAGE),
            ),
          ],
        ),
      ),
    );
  }

  // For setting and logout
  Widget _getDrawerMenuItem(
    BuildContext context, {
    required String label,
    required Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10, left: 5),
          child: InkWell(
            onTap: onTap,
            child: Text(
              label,
              style: AppTextStyle.F22_BOLD,
            ),
          ),
        ),
        Container(
          height: 1.5,
          color: AppColors.GREY_MED,
        )
      ],
    );
  }

  Widget _getBottomNavigationBar(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: const BoxDecoration(
        color: AppColors.WHITE,
        boxShadow: [
          BoxShadow(
            color: AppColors.GREY_MED,
            offset: Offset(1.5, 0),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getIconButton(context, icon: Icons.home, index: 0),
          _getIconButton(context, icon: Icons.notifications, index: 1),
          _getIconButton(context, icon: Icons.favorite, index: 2),
          _getIconButton(context, icon: Icons.restaurant, index: 3),
        ],
      ),
    );
  }

  // Icon button for navigation bar menu item
  Widget _getIconButton(
    BuildContext context, {
    required IconData icon,
    required int index,
  }) {
    bool isSelected = _pageIndex == index;
    return InkWell(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      },
      child: AnimatedContainer(
        width: 60,
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ORANGE_FE7455 : AppColors.WHITE,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.WHITE : AppColors.GREY_DARK,
          size: 30,
        ),
      ),
    );
  }
}
