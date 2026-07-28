import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:flutter/material.dart';

/// A single "Upload X" row on the Upload Data screen: a leading icon, a
/// title, and a circular upload button on the trailing edge.
class TUploadDataTile extends StatelessWidget {
  const TUploadDataTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: TSizes.iconMd, color: TColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: IconButton(
        onPressed: onTap,
        icon: Container(
          padding: const EdgeInsets.all(TSizes.xs),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: TColors.primary),
          ),
          child: Icon(Icons.arrow_upward, size: TSizes.iconSm, color: TColors.primary),
        ),
      ),
      onTap: onTap,
    );
  }
}
