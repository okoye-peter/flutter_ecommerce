import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/utils/validators/validator.dart';
import 'package:ecommerce/core/widgets/images/circular_image.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/views/profile/widgets/change_profile_picture.dart';
import 'package:ecommerce/views/profile/widgets/delete_account_dialog.dart';
import 'package:ecommerce/views/profile/widgets/edit_field_sheet.dart';
import 'package:ecommerce/views/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TProfileDetails extends ConsumerWidget {
  const TProfileDetails({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              // Profile Picture
              TCircularImage(
                image: user.profilePicture.isNotEmpty
                    ? user.profilePicture
                    : TImages.userFemaleAvatar,
                isNetworkImage: user.profilePicture.isNotEmpty,
                width: 80,
                height: 80,
                
              ),
              TextButton(
                onPressed: () => pickAndUploadProfilePicture(context, ref),
                child: const Text('Change Profile Picture'),
              ),
            ],
          ),
        ),

        // Details
        const SizedBox(height: TSizes.spaceBtwItem / 2),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItem),
        TSectionHeading(
          title: 'Profile Information',
          showActionButton: false,
        ),
        const SizedBox(height: TSizes.spaceBtwItem),

        TProfileMenu(
          label: 'Name',
          value: user.fullName,
          onPressed: () => showEditFieldSheet(
            context,
            label: 'Name',
            icon: Icons.person_outline,
            currentValue: user.fullName,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            buildUpdate: (value) {
              final parts = UserModel.nameParts(value);
              return {
                'firstName': parts[0],
                'lastName': parts.length > 1 ? parts.sublist(1).join(' ') : '',
              };
            },
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItem),
        TProfileMenu(
          label: 'Username',
          value: user.username,
          onPressed: () => showEditFieldSheet(
            context,
            label: 'Username',
            icon: Icons.alternate_email,
            currentValue: user.username,
            validator: (value) =>
                TValidator.validateEmptyText('Username', value),
            buildUpdate: (value) => {'username': value},
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItem),

        TSectionHeading(
          title: 'Profile Information',
          showActionButton: false,
        ),
        const SizedBox(height: TSizes.spaceBtwItem),

        TProfileMenu(
          label: 'User ID',
          value: user.id,
          onPressed: () {},
          icon: Icons.copy,
        ),
        const SizedBox(height: TSizes.spaceBtwItem),
        TProfileMenu(
          label: 'Email',
          value: user.email,
          onPressed: () => showEditFieldSheet(
            context,
            label: 'Email',
            icon: Icons.email_outlined,
            currentValue: user.email,
            keyboardType: TextInputType.emailAddress,
            validator: TValidator.validateEmail,
            buildUpdate: (value) => {'email': value},
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItem),
        TProfileMenu(
          label: 'Phone Number',
          value: user.formattedPhoneNo,
          onPressed: () => showEditFieldSheet(
            context,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
            currentValue: user.phoneNumber,
            keyboardType: TextInputType.phone,
            validator: TValidator.validatePhoneNumber,
            buildUpdate: (value) => {'phoneNumber': value},
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItem),

        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItem),

        Center(
          child: TextButton(
            onPressed: () =>
                openDeleteAccountConfirmation(context, ref, email: user.email),
            child: Text(
              'Close Account',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
