import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/constants/button_style.dart';
import 'package:food_recipes_flutter/cubit/page_view_btn/page_view_btn_cubit.dart';
import 'package:food_recipes_flutter/firebase/auth.dart';

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
  final _pageViewBtnCubit = PageViewBtnCubit();

  final PageController _pageController = PageController();

  final AppAuth _appAuth = AppAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.ORANGE_FE7455,
        toolbarHeight: 70,
        title: Text(
          UIString.APP_NAME,
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
                _pageViewBtnCubit.changePageIndex(value);
              },
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: AppRoute.allPageView(),
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
        padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(
          children: [
            // Image and username
            const Icon(
              Icons.person,
              size: 50,
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppAuth.userData.displayName,
                  style: AppTextStyle.F20_BOLD.copyWith(
                    color: AppColors.ORANGE_FE7455,
                  ),
                ),
                Text(
                  AppAuth.userData.email,
                  style: AppTextStyle.F14_NORMAL,
                ),
              ],
            ),
            const SizedBox(height: 15),
            _getDrawerMenuButton(
              context,
              label: UIString.SETTING_DRAWER,
              onTap: () {},
            ),
            _getDrawerMenuButton(
              context,
              label: UIString.LOGOUT_DRAWER,
              onTap: () async {
                await _appAuth.logout().then(
                  (value) {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoute.LOGIN_PAGE,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // For setting and logout
  Widget _getDrawerMenuButton(
    BuildContext context, {
    required String label,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: onTap,
        style: AppButtonStyle.WHITE_BTN,
        child: Center(
          child: Text(
            label,
            style: AppTextStyle.F22_BOLD,
          ),
        ),
      ),
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
            color: AppColors.MED_GREY,
            offset: Offset(1.5, 0),
            blurRadius: 8,
          )
        ],
      ),
      child: BlocBuilder<PageViewBtnCubit, PageViewBtnState>(
        bloc: _pageViewBtnCubit,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getIconButton(
                context,
                icon: Icons.home,
                index: 0,
                state: state,
              ),
              _getIconButton(
                context,
                icon: Icons.notifications,
                index: 1,
                state: state,
              ),
              _getIconButton(
                context,
                icon: Icons.favorite,
                index: 2,
                state: state,
              ),
              _getIconButton(
                context,
                icon: Icons.restaurant,
                index: 3,
                state: state,
              ),
            ],
          );
        },
      ),
    );
  }

  // Icon button for navigation bar menu item
  Widget _getIconButton(
    BuildContext context, {
    required IconData icon,
    required int index,
    required PageViewBtnState state,
  }) {
    bool isSelected = state.pageIndex == index;
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
          color: isSelected ? AppColors.WHITE : AppColors.DARK_GREY,
          size: 30,
        ),
      ),
    );
  }
}
