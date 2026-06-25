import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/images/circular_image.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/views/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Profile'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // Profile Picture
                    const TCircularImage(
                      image: TImages.userFemaleAvatar,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              // Details
              const SizedBox(height: TSizes.spaceBtwItem / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItem,),
              TSectionHeading(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItem,),

              TProfileMenu(label: 'Name', value: 'Okoye Dev', onPressed: (){},),
              const SizedBox(height: TSizes.spaceBtwItem,),
              TProfileMenu(label: 'Username', value: 'OkoyeDev', onPressed: (){},),

              const SizedBox(height: TSizes.spaceBtwItem / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItem,),


              TSectionHeading(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItem,),

              TProfileMenu(label: 'User ID', value: '43356', onPressed: (){}, icon: Icons.copy,),
              const SizedBox(height: TSizes.spaceBtwItem,),
              TProfileMenu(label: 'Email', value: 'okoye@dev.com', onPressed: (){},),
              const SizedBox(height: TSizes.spaceBtwItem,),
              TProfileMenu(label: 'Phone Number', value: '+2348103078096', onPressed: (){},),
              const SizedBox(height: TSizes.spaceBtwItem,),
              TProfileMenu(label: 'Gender', value: 'Male', onPressed: (){},),
              const SizedBox(height: TSizes.spaceBtwItem,),
              TProfileMenu(label: 'Date of Birth', value: '10 Oct, 1994', onPressed: (){},),
              const SizedBox(height: TSizes.spaceBtwItem,),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItem,),

              Center(
                child: TextButton(onPressed: () {}, child: Text('Close Account', style: TextStyle(color: Colors.red),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

