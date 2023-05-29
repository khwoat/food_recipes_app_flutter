import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';
import 'app_card.dart';

class RecipeCard extends StatefulWidget {
  final String _recipeName;
  final String _username;
  final String? _imagePath;
  const RecipeCard(
      {required String recipeName,
      required String username,
      String? imagePath,
      super.key})
      : _recipeName = recipeName,
        _username = username,
        _imagePath = imagePath;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            height: 100,
            clipBehavior: Clip.none,
            child: Image.network(
              widget._imagePath ?? "",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      widget._recipeName,
                      style: AppTextStyle.F18_BOLD.copyWith(
                        color: AppColors.GREY_DARK,
                      ),
                    ),
                  ),
                  Text(
                    "by ${widget._username}",
                    style: AppTextStyle.F14_NORMAL.copyWith(
                      color: AppColors.GREY_DARK,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
