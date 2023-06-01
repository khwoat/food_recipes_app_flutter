import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';
import '../constants/string.dart';
import '../constants/text_style.dart';
import '../cubit/favorite_list/favorite_list_cubit.dart';
import '../model/recipe_list.dart';
import '../widgets/recipe_card.dart';

class UserRecipesPage extends StatefulWidget {
  const UserRecipesPage({super.key});

  @override
  State<UserRecipesPage> createState() => _UserRecipesPageState();
}

class _UserRecipesPageState extends State<UserRecipesPage> {
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
              AppString.USER_RECIPES_HEADER,
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
