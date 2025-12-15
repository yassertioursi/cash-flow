import 'package:cashflow/core/presentation/widgets/shimmers/shimmer_container.dart';
import 'package:flutter/material.dart';

class ShimmerCircle extends StatelessWidget {

  final double size;
  const ShimmerCircle({
    super.key,
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ShimmerContainer(
        width: size,
        height: size,
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
