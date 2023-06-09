import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes_flutter/bloc_provider.dart';
import 'package:food_recipes_flutter/constants/colors.dart';
import 'package:food_recipes_flutter/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: AppBlocProvider().getAllProvider(),
    child: const FoodRecipesApp(),
  ));
}

class FoodRecipesApp extends StatelessWidget {
  const FoodRecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoute.SPLASH_PAGE,
        routes: AppRoute.allRoutes(context),
        theme: ThemeData(
          fontFamily: "Prompt",
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            background: AppColors.WHITE,
            onBackground: AppColors.ORANGE_FE7455,
            primary: AppColors.ORANGE_FE7455,
            onPrimary: AppColors.WHITE,
            secondary: AppColors.ORANGE_FE7455,
            onSecondary: AppColors.WHITE,
            error: AppColors.RED,
            onError: AppColors.WHITE,
            surface: AppColors.LIGHT_GREY,
            onSurface: AppColors.ORANGE_FE7455,
          ),
        ),
      ),
    );
  }
}
