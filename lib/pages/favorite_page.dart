import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/cubit/favorite_list/favorite_list_cubit.dart';
import 'package:food_recipes_flutter/widgets/recipe_card.dart';

import '../model/recipe_list.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<Recipe> _recipeList = [
    Recipe(
      recipeName: "Tom yum kung",
      username: "Josh",
      detailList: [
        RecipeDetail(index: 1, description: "description1"),
      ],
      imageList: ["images/tom_yum_kung.webp"],
    ),
    Recipe(
      recipeName: "Pad Thai",
      username: "David",
      detailList: [
        RecipeDetail(index: 1, description: "description1"),
      ],
      imageList: ["images/tom_yum_kung.webp"],
    ),
  ];

  late final FavoriteListCubit _favoriteListCubit;

  @override
  void didChangeDependencies() {
    _favoriteListCubit = BlocProvider.of<FavoriteListCubit>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _favoriteListCubit.init(_recipeList);
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
              AppString.FAV_HEADER,
              style: AppTextStyle.F22_BOLD.copyWith(
                color: AppColors.GREY_DARK,
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
                        recipeName: fav.recipeName,
                        username: fav.username,
                        imagePath: fav.imageList.first,
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
