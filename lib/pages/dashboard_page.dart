import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/string.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/widgets/recipe_card.dart';
import '../cubit/dropdown/dropdown_cubit.dart';
import '../cubit/recipe_list/recipe_list_cubit.dart';
import '../model/recipe.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
      _cateDropdownCubit.getValueList(FirestoreString.CATEGORIES_DOC);
      _sortDropdownCubit.getValueList(FirestoreString.SORTING_DOC);
      _recipesCubit.getRecipeList();
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
                bloc: _recipesCubit,
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
    required int value,
    required List<String> valueList,
    required void Function(int? value) onChanged,
  }) {
    return DropdownButton<int>(
      value: value,
      onChanged: onChanged,
      underline: Container(),
      items: valueList
          .map((e) => _getDropdownItem(context, valueList.indexOf(e), e))
          .toList(),
    );
  }

  DropdownMenuItem<int> _getDropdownItem(
    BuildContext context,
    int id,
    String value,
  ) {
    return DropdownMenuItem(
      value: id,
      child: Text(
        value,
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
            return _getDropdownButton(context,
                value: state.selectedValue,
                valueList: state.valueList, onChanged: (value) {
              _cateDropdownCubit.selectNewValue(value ?? 0);
              _recipesCubit.filterRecipes(
                cateId: value ?? 0,
                sortId: _sortDropdownCubit.state.selectedValue,
                sortingList: _sortDropdownCubit.state.valueList,
              );
            });
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
              onChanged: (value) {
                _sortDropdownCubit.selectNewValue(value ?? 0);
                _recipesCubit.filterRecipes(
                  cateId: _cateDropdownCubit.state.selectedValue,
                  sortId: value ?? 0,
                  sortingList: state.valueList,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
