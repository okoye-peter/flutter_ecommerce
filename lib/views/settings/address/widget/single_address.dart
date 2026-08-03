import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/models/address_model.dart';
import 'package:flutter/material.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final AddressModel address;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final isSelected = address.isSelectedAddress ?? false;
    return InkWell(
      onTap: onTap,
      child: TRoundedContainer(
        padding: EdgeInsets.all(TSizes.md),
        width: double.infinity,
        showBorder: true,
        backgroundColor: isSelected
            ? TColors.primary.withAlpha(126)
            : Colors.transparent,
        borderColor: isSelected
            ? Colors.transparent
            : (dark ? TColors.darkGrey : TColors.grey),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItem),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(
                    address.formattedPhoneNo,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(address.toString(), softWrap: true),
                ],
              ),
            ),
            // if (isSelected)
            //   Icon(
            //     Icons.check_circle,
            //     color: dark
            //         ? TColors.light
            //         : TColors.dark.withValues(alpha: 0.7),
            //   ),
            if (onEdit != null || onDelete != null)
              PopupMenuButton<VoidCallback>(
                position: PopupMenuPosition.under,
                icon: Icon(
                  Icons.more_vert,
                  color: dark ? TColors.light : TColors.dark,
                ),
                onSelected: (action) => action(),
                itemBuilder: (context) => [
                  if (onEdit != null)
                    PopupMenuItem(value: onEdit, child: const Text('Edit')),
                  if (onDelete != null)
                    PopupMenuItem(value: onDelete, child: const Text('Delete')),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
