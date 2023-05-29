import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/cubit/recipes/recipes_cubit.dart';
import 'package:food_recipes_flutter/cubit/sort_dropdown/sort_dropdown_cubit.dart';
import 'package:food_recipes_flutter/widgets/app_card.dart';

import '../cubit/cate_dropdown/cate_dropdown_cubit.dart';
import '../model/recipe.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> _categoryList = ["Category", "Boiled"];
  final List<String> _sortingList = ["Popularity", "Name"];

  final List<Recipe> _recipeList = [
    Recipe(
      recipeName: "Tom yum kung",
      username: "Josh",
      detailList: [
        RecipeDetail(index: 1, description: "description1"),
      ],
      imageList: [],
    ),
    Recipe(
      recipeName: "Tom yum kung",
      username: "Josh",
      detailList: [
        RecipeDetail(index: 1, description: "description1"),
      ],
      imageList: [],
    ),
  ];

  late final CategoryDropdownCubit _cateDropdownCubit;
  late final SortDropdownCubit _sortDropdownCubit;
  late final RecipesCubit _recipesCubit;

  @override
  void didChangeDependencies() {
    _cateDropdownCubit = BlocProvider.of<CategoryDropdownCubit>(context);
    _sortDropdownCubit = BlocProvider.of<SortDropdownCubit>(context);
    _recipesCubit = BlocProvider.of<RecipesCubit>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cateDropdownCubit.init(_categoryList);
      _sortDropdownCubit.init(_sortingList);
      _recipesCubit.init(_recipeList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.ORANGE_FE7455,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.person),
        ),
        centerTitle: true,
        title: Text(
          AppString.APP_NAME,
          textAlign: TextAlign.center,
          style: AppTextStyle.F24_BOLD.copyWith(
            color: AppColors.WHITE,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Category dropdown
              BlocBuilder<CategoryDropdownCubit, CategoryDropdownState>(
                builder: (context, state) {
                  return _getDropdownButton(
                    context,
                    value: state.selectedValue,
                    valueList: state.valueList,
                    onChanged: (value) =>
                        _cateDropdownCubit.selectNewValue(value ?? ""),
                  );
                },
              ),
              const SizedBox(width: 10),
              // Sorting dropdown
              BlocBuilder<SortDropdownCubit, SortDropdownState>(
                builder: (context, state) {
                  return _getDropdownButton(
                    context,
                    value: state.selectedValue,
                    valueList: state.valueList,
                    onChanged: (value) =>
                        _sortDropdownCubit.selectNewValue(value ?? ""),
                  );
                },
              ),
            ],
          ),

          // Recipe list card
          Expanded(
            child: BlocBuilder<RecipesCubit, RecipesState>(
              builder: (context, state) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: state.recipeList.length,
                  itemBuilder: (context, index) =>
                      _getRecipeItem(context, state.recipeList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown btn for "Category" and "Sorting"
  Widget _getDropdownButton(
    BuildContext context, {
    required String value,
    required List<String> valueList,
    required void Function(String? value) onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      underline: Container(),
      items: valueList.map((e) => _getDropdownItem(context, e)).toList(),
    );
  }

  DropdownMenuItem<String> _getDropdownItem(BuildContext context, String text) {
    return DropdownMenuItem(
      value: text,
      child: Text(
        text,
        style: AppTextStyle.F18_NORMAL.copyWith(
          color: AppColors.GREY_DARK,
        ),
      ),
    );
  }

  Widget _getRecipeItem(BuildContext context, Recipe recipe) {
    return AppCard(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        Expanded(
          child: Text(
            recipe.recipeName,
            style: AppTextStyle.F18_BOLD.copyWith(
              color: AppColors.GREY_DARK,
            ),
          ),
        ),
        Text(
          "by ${recipe.username}",
          style: AppTextStyle.F14_NORMAL.copyWith(
            color: AppColors.GREY_DARK,
          ),
        ),
      ]),
    );
  }
}
