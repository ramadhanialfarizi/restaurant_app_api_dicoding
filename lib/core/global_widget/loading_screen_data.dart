import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';

class DefaultScreenLoading extends StatelessWidget {
  final Color? indicatorColor;
  final Color? backgroundColor;
  const DefaultScreenLoading({
    super.key,
    this.indicatorColor = ColorsConstant.primaryColors,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
          color: backgroundColor ?? Colors.black.withOpacity(0.1),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: CircularProgressIndicator(
                color: indicatorColor ?? Theme.of(context).colorScheme.primary,
              ),
            ),
          )),
    );
  }
}
