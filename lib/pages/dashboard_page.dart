import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/widgets/recipe_card.dart';
import '../cubit/dropdown/dropdown_cubit.dart';
import '../cubit/recipe_list/recipe_list_cubit.dart';
import '../model/recipe_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> _categoryList = ["Category", "Boiled"];
  final List<String> _sortingList = ["Sorting", "Popularity", "Name"];

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

  final DropdownCubit _cateDropdownCubit = DropdownCubit();
  final DropdownCubit _sortDropdownCubit = DropdownCubit();
  late final RecipeListCubit _recipesCubit;

  bool isShowSearchBox = false;

  @override
  void didChangeDependencies() {
    _recipesCubit = BlocProvider.of<RecipeListCubit>(context);
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: !isShowSearchBox
                        ? _getCateSortDropdown(context)
                        : SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: AppColors.LIGHT_GREY,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isShowSearchBox = !isShowSearchBox;
                    });
                  },
                  icon: Icon(
                    isShowSearchBox ? Icons.close : Icons.search,
                    color: AppColors.DARK_GREY,
                  ),
                ),
              ],
            ),

            // Recipe card grid view
            Expanded(
              child: BlocBuilder<RecipeListCubit, RecipeListState>(
                builder: (context, state) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220,
                    ),
                    itemCount: state.recipeList.length,
                    itemBuilder: (context, index) {
                      final Recipe recipe = state.recipeList[index];
                      return RecipeCard(
                        recipeName: recipe.recipeName,
                        username: recipe.username,
                        imagePath: recipe.imageList.first,
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
          color: AppColors.DARK_GREY,
        ),
      ),
    );
  }

  Widget _getCateSortDropdown(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Category dropdown
        BlocBuilder<DropdownCubit, DropdownState>(
          bloc: _cateDropdownCubit,
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
        BlocBuilder<DropdownCubit, DropdownState>(
          bloc: _sortDropdownCubit,
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
    );
  }
}
