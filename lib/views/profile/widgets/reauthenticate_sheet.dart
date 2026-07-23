import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/utils/validators/validator.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Bottom sheet that verifies the current user's password before an
/// irreversible action (e.g. account deletion) is allowed to proceed.
/// Pops `true` once re-authentication succeeds, `false` on cancel.
class TReauthenticateSheet extends ConsumerStatefulWidget {
  const TReauthenticateSheet({super.key, required this.email});

  final String email;

  @override
  ConsumerState<TReauthenticateSheet> createState() =>
      _TReauthenticateSheetState();
}

class _TReauthenticateSheetState extends ConsumerState<TReauthenticateSheet> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isVerifying = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isVerifying = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .reAuthenticateWithEmailAndPassword(
            widget.email,
            _passwordController.text,
          );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isVerifying = false);
      TSnacksLoader.errorSnackBar(
        title: 'Could not verify password',
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          TSizes.defaultSpace,
          TSizes.sm,
          TSizes.defaultSpace,
          TSizes.defaultSpace,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(TSizes.cardRadiusLg),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 4,
                    margin: const EdgeInsets.only(
                      bottom: TSizes.spaceBtwItem,
                    ),
                    decoration: BoxDecoration(
                      color: TColors.darkGrey,
                      borderRadius: BorderRadius.circular(
                        TSizes.borderRadiusSm,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: TColors.error.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.lock_outline,
                        color: TColors.error,
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItem),
                    Expanded(
                      child: Text(
                        'Confirm Your Password',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItem / 2),
                Text(
                  'For your security, enter your password to permanently delete your account.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItem),
                TextFormField(
                  initialValue: widget.email,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: _passwordController,
                  autofocus: true,
                  obscureText: _obscurePassword,
                  enabled: !_isVerifying,
                  validator: (value) =>
                      TValidator.validateEmptyText('Password', value),
                  onFieldSubmitted: (_) => _confirm(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isVerifying
                            ? null
                            : () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItem),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.error,
                          disabledBackgroundColor: TColors.error,
                          side: BorderSide.none,
                        ),
                        onPressed: _isVerifying ? null : _confirm,
                        child: _isVerifying
                            ? const SizedBox(
                                width: 20,
                                height: 20,

                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Confirm & Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
