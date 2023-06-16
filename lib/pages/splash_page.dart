import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
// import 'package:food_recipes_flutter/cubit/favorite_list/favorite_list_cubit.dart';
// import 'package:food_recipes_flutter/cubit/recipe_list/recipe_list_cubit.dart';
import 'package:food_recipes_flutter/firebase/auth.dart';

import '../route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AppAuth _appAuth = AppAuth.instance;

  // late final RecipeListCubit _recipeListCubit;
  // late final FavoriteListCubit _favoriteListCubit;

  // late final Timer timer;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _appAuth.getUserSession().then((value) {
        // For waiting to load the recipe list and fav list data
        // Before push to home or login page
        // _recipeListCubit = BlocProvider.of<RecipeListCubit>(context);
        // _favoriteListCubit = BlocProvider.of<FavoriteListCubit>(context);

        Navigator.of(context).popAndPushNamed(
          value ? AppRoute.HOME_PAGE : AppRoute.LOGIN_PAGE,
        );

        // timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
        //   if (_recipeListCubit.state is RecipeListSuccess &&
        //       _favoriteListCubit.state is FavoriteListSuccess) {
        //     Navigator.of(context).popAndPushNamed(
        //       value ? AppRoute.HOME_PAGE : AppRoute.LOGIN_PAGE,
        //     );
        //   }
        // });
        // WidgetsBinding.instance.addTimingsCallback((_) {
        //   if (_recipeListCubit.state is RecipeListSuccess &&
        //       _favoriteListCubit.state is FavoriteListSuccess) {
        //     Navigator.of(context).pushReplacementNamed(
        //       value ? AppRoute.HOME_PAGE : AppRoute.LOGIN_PAGE,
        //     );
        //   }
        // });
      });
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.ORANGE_FE7455,
        child: Center(
          child: Text(
            UIString.APP_NAME_NEW_LINE,
            textAlign: TextAlign.center,
            style: AppTextStyle.F30_BOLD.copyWith(
              color: AppColors.WHITE,
              fontFamily: "Forte",
            ),
          ),
        ),
      ),
    );
  }
}
