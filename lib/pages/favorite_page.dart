import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/cubit/favorite_list/favorite_list_cubit.dart';
import 'package:food_recipes_flutter/widgets/recipe_card.dart';

import '../model/recipe.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late final FavoriteListCubit _favoriteListCubit;

  @override
  void didChangeDependencies() {
    _favoriteListCubit = BlocProvider.of<FavoriteListCubit>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _favoriteListCubit.getFavoriteList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              UIString.FAV_HEADER,
              style: AppTextStyle.F22_BOLD.copyWith(
                color: AppColors.DARK_GREY,
              ),
            ),

            const SizedBox(height: 5),

            // Fav list grid
            Expanded(
              child: BlocBuilder<FavoriteListCubit, FavoriteListState>(
                builder: (context, state) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220,
                    ),
                    itemCount: state.favList.length,
                    itemBuilder: (context, index) {
                      final Recipe fav = state.favList[index];
                      return RecipeCard(
                        recipe: fav,
                        onTapFav: () => _favoriteListCubit.changeFav(fav),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
