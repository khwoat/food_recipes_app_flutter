import 'package:flutter/material.dart';
import 'package:food_recipes_flutter/constants/colors.dart';

class AppCard extends StatefulWidget {
  final Widget _child;
  final EdgeInsets? _margin;
  final EdgeInsets? _padding;
  final Color? _backgroundColor;
  final BorderRadius? _borderRadius;

  const AppCard({
    required Widget child,
    EdgeInsets? margin = const EdgeInsets.all(10.0),
    EdgeInsets? padding = const EdgeInsets.all(10.0),
    Color? backgroundColor = AppColors.WHITE,
    BorderRadius? borderRadius,
    super.key,
  })  : _child = child,
        _margin = margin,
        _padding = padding,
        _backgroundColor = backgroundColor,
        _borderRadius = borderRadius;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget._margin,
      padding: widget._padding,
      decoration: BoxDecoration(
        color: widget._backgroundColor,
        borderRadius: widget._borderRadius ?? BorderRadius.circular(20.0),
      ),
      child: widget._child,
    );
  }
}
