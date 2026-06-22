import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/widgets/curved_edges/circular_container.dart';
import 'package:ecommerce/core/widgets/curved_edges/curved_edge_widget.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backgroundColor: TColors.textWhite.withAlpha(26),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                backgroundColor: TColors.textWhite.withAlpha(26),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
