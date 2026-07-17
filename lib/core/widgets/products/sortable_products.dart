import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:flutter/material.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
          items:
              [
                    'name',
                    'Higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popularity',
                  ]
                  .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
          onChanged: (value) {},
        ),

        const SizedBox(height: TSizes.spaceBtwSections,),

        // Products
        TGridLayout(itemCount: 8, itemBuilder: (context, index) => TProductCardVertical())
      ],
    );
  }
}
