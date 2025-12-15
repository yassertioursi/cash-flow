import 'package:cashflow/core/presentation/widgets/shimmers/shimmer_container.dart';
import 'package:flutter/material.dart';

class ShimmerText extends StatelessWidget {

  final double width;

  final double height;
  const ShimmerText({
    super.key,
    required this.width,
    this.height = 16.0,
  });
  @override
  Widget build(BuildContext context) {
    return ShimmerContainer(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
