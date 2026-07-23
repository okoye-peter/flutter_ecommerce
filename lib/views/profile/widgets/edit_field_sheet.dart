import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/viewmodels/auth/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Opens a bottom sheet to edit a single profile field and persist it via
/// [UserController.updateField].
Future<void> showEditFieldSheet(
  BuildContext context, {
  required String label,
  required IconData icon,
  required String currentValue,
  required Map<String, dynamic> Function(String value) buildUpdate,
  String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => TEditFieldSheet(
      label: label,
      icon: icon,
      currentValue: currentValue,
      buildUpdate: buildUpdate,
      validator: validator,
      keyboardType: keyboardType,
    ),
  );
}

class TEditFieldSheet extends ConsumerStatefulWidget {
  const TEditFieldSheet({
    super.key,
    required this.label,
    required this.icon,
    required this.currentValue,
    required this.buildUpdate,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final IconData icon;
  final String currentValue;
  final Map<String, dynamic> Function(String value) buildUpdate;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  ConsumerState<TEditFieldSheet> createState() => _TEditFieldSheetState();
}

class _TEditFieldSheetState extends ConsumerState<TEditFieldSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _controller = TextEditingController(text: widget.currentValue);
  bool _isSaving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final newValue = _controller.text.trim();
    if (newValue == widget.currentValue) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isSaving = true);
    final success = await ref
        .read(userControllerProvider.notifier)
        .updateField(widget.buildUpdate(newValue));

    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop();
      TSnacksLoader.successSnackBar(title: '${widget.label} updated');
    } else {
      setState(() => _isSaving = false);
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
                      backgroundColor: TColors.primary.withValues(alpha: 0.1),
                      child: Icon(widget.icon, color: TColors.primary),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItem),
                    Expanded(
                      child: Text(
                        'Edit ${widget.label}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItem),
                TextFormField(
                  controller: _controller,
                  autofocus: true,
                  enabled: !_isSaving,
                  keyboardType: widget.keyboardType,
                  validator: widget.validator,
                  onFieldSubmitted: (_) => _save(),
                  decoration: InputDecoration(
                    labelText: widget.label,
                    prefixIcon: Icon(widget.icon),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isSaving
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItem),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        child: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Save'),
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
