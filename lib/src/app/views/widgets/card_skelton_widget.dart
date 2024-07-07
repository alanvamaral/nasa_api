import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardSkeltonWidget extends StatelessWidget {
  const CardSkeltonWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 900),
      baseColor: Colors.black.withOpacity(0.4),
      highlightColor: Colors.black.withOpacity(0.305),
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
      ),
    );
  }
}
