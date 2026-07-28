import 'package:flutter/material.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currencySign = '\$',
    required this.price,
    this.isLarge = false,
    this.smallSize = false,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool smallSize;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    final decoration = lineThrough ? TextDecoration.lineThrough : null;
    final style = isLarge
        ? Theme.of(context).textTheme.headlineMedium!
        : smallSize
        ? Theme.of(context).textTheme.bodyLarge!
        : Theme.of(context).textTheme.titleLarge!;

    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style.apply(decoration: decoration),
    );
  }
}
