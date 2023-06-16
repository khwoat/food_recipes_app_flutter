import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/cubit/favorite_list/favorite_list_cubit.dart';
import 'package:food_recipes_flutter/cubit/recipe_data/recipe_data_cubit.dart';
import 'package:food_recipes_flutter/model/recipe_model.dart';
import 'package:food_recipes_flutter/repository/recipe_repository.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';
import 'app_card.dart';

// Reusable recipe card
class RecipeCard extends StatefulWidget {
  const RecipeCard({required Recipe recipe, super.key}) : _recipe = recipe;

  final Recipe _recipe;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  final _recipeRepository = RecipeRepository();

  late final RecipeDataCubit _recipeDataCubit;

  late final FavoriteListCubit _favoriteListCubit;

  @override
  void didChangeDependencies() {
    _favoriteListCubit = BlocProvider.of<FavoriteListCubit>(context);
    _recipeDataCubit = RecipeDataCubit(
      recipeRepository: _recipeRepository,
      id: widget._recipe.id,
    );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Column(
            children: [
              // Recipe banner
              SizedBox(
                height: 120,
                child: (widget._recipe.imageList.first != "")
                    ? Image.network(
                        widget._recipe.imageList.first,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "images/tom_yum_kung.webp",
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          widget._recipe.recipeName,
                          style: AppTextStyle.F18_BOLD.copyWith(
                            color: AppColors.DARK_GREY,
                          ),
                        ),
                      ),
                      Text(
                        "by ${widget._recipe.displayName}",
                        style: AppTextStyle.F14_NORMAL.copyWith(
                          color: AppColors.MED_GREY,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Favorite icon
          _getFavoriteButton(context),
        ],
      ),
    );
  }

  Widget _getFavoriteButton(BuildContext context) {
    return BlocBuilder<RecipeDataCubit, RecipeDataState>(
      bloc: _recipeDataCubit,
      builder: (context, state) {
        return Positioned(
          top: 5,
          right: 10,
          child: GestureDetector(
            onTap: () async {
              await _recipeDataCubit.changeFav(
                widget._recipe,
                state.recipe?.isFav ?? false,
              );
              await _favoriteListCubit.getFavoriteList();
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation.drive(Tween<double>(
                    begin: 1.5,
                    end: 1,
                  )),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: (state.recipe?.isFav ?? false)
                  ? const Icon(
                      Icons.favorite,
                      key: ValueKey(1),
                      color: AppColors.ORANGE_FE7455,
                      size: 35,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      key: ValueKey(2),
                      color: AppColors.WHITE,
                      size: 35,
                    ),
            ),
          ),
        );
      },
    );
  }
}
