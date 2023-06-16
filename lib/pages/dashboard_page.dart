import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/constants/text_style.dart';
import 'package:food_recipes_flutter/widgets/recipe_card.dart';
import '../cubit/dropdown/dropdown_cubit.dart';
import '../cubit/recipe_list/recipe_list_cubit.dart';
import '../model/recipe_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final RecipeListCubit _recipesCubit;
  late final DropdownCubit _cateDropdownCubit;
  late final DropdownCubit _sortDropdownCubit;

  bool isShowSearchBox = false;

  @override
  void didChangeDependencies() {
    _recipesCubit = BlocProvider.of<RecipeListCubit>(context);
    _cateDropdownCubit =
        BlocProvider.of<DropdownCubit<CateDropdownType>>(context);
    _sortDropdownCubit =
        BlocProvider.of<DropdownCubit<SortDropdownType>>(context);

    _recipesCubit.filterRecipes(
      cateId: _cateDropdownCubit.state.selectedValue,
      sortId: _sortDropdownCubit.state.selectedValue,
      sortingList: _sortDropdownCubit.state.valueList,
    );
    super.didChangeDependencies();
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
                builder: (context, recipeState) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220,
                    ),
                    itemCount: recipeState.recipeList.length,
                    itemBuilder: (context, index) {
                      final Recipe recipe = recipeState.recipeList[index];
                      return RecipeCard(recipe: recipe);
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
      alignment: AlignmentDirectional.centerEnd,
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
            return _getDropdownButton(
              context,
              value: state.selectedValue,
              valueList: state.valueList,
              onChanged: (value) async {
                _cateDropdownCubit.selectNewValue(value ?? 0);

                await _recipesCubit.getRecipeList();
                _recipesCubit.filterRecipes(
                  cateId: value ?? 0,
                  sortId: _sortDropdownCubit.state.selectedValue,
                  sortingList: _sortDropdownCubit.state.valueList,
                );
              },
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
              onChanged: (value) async {
                _sortDropdownCubit.selectNewValue(value ?? 0);

                await _recipesCubit.getRecipeList();
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
