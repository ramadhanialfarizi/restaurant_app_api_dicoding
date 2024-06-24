import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoadingComponent extends StatelessWidget {
  const SkeletonLoadingComponent({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.animDuration,
  });

  final Widget child;

  final Color? baseColor;

  final Color? highlightColor;

  final Duration? animDuration;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.withOpacity(0.2),
      highlightColor: highlightColor ?? Colors.white,
      period: animDuration ?? const Duration(seconds: 1),
      child: child,
    );
  }
}
