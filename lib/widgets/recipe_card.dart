import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/model/recipe.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';
import 'app_card.dart';

// Reusable recipe card
class RecipeCard extends StatefulWidget {
  const RecipeCard(
      {required Recipe recipe, required Function() onTapFav, super.key})
      : _recipe = recipe,
        _onTap = onTapFav;

  final Recipe _recipe;
  final Function() _onTap;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
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
                child: (widget._recipe.imageList.first != null &&
                        widget._recipe.imageList.first != "")
                    ? Image.network(
                        widget._recipe.imageList.first ?? "",
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
          Positioned(
            top: 8,
            right: 10,
            child: GestureDetector(
              onTap: widget._onTap,
              child: Icon(
                (widget._recipe.isFav)
                    ? Icons.favorite
                    : Icons.favorite_outline,
                color: (widget._recipe.isFav)
                    ? AppColors.ORANGE_FE7455
                    : AppColors.WHITE,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
