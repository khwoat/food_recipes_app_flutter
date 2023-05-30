import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/pages/dashboard_page.dart';
import 'package:food_recipes_flutter/pages/favorite_page.dart';

import '../constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pageList = [const DashboardPage(), const FavoritePage()];

  final PageController _pageController = PageController();

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    ));
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
          _getIconButton(context, icon: Icons.folder_shared, index: 3),
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
