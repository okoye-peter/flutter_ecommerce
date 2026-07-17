import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Utility for showing themed, floating snack bars (success / warning / error).
class TSnacksLoader {
  const TSnacksLoader._();

  static void _snackbar({
    required String title,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
    required Duration duration,
    required EdgeInsets margin,
    bool shouldIconPulse = true,
  }) {
    final context = rootNavigatorKey.currentContext!;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          margin: margin,
          duration: duration,
          dismissDirection: DismissDirection.horizontal,
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PulsingIcon(
                icon: icon,
                color: textColor,
                pulse: shouldIconPulse,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (message.isNotEmpty)
                      Text(
                        message,
                        style: TextStyle(color: textColor),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    _snackbar(
      title: title,
      message: message,
      textColor: TColors.white,
      backgroundColor: TColors.primary,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: Iconsax.tick_circle,
    );
  }

  static void warningSnackBar({required String title, String message = ''}) {
    _snackbar(
      title: title,
      message: message,
      textColor: TColors.white,
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: Iconsax.warning_2,
    );
  }

  static void errorSnackBar({required String title, String message = ''}) {
    _snackbar(
      title: title,
      message: message,
      textColor: TColors.white,
      backgroundColor: Colors.red.shade600,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: Iconsax.warning_2,
    );
  }
}

/// Small icon that gently pulses in place, mirroring GetX's `shouldIconPulse`.
class _PulsingIcon extends StatefulWidget {
  const _PulsingIcon({
    required this.icon,
    required this.color,
    required this.pulse,
  });

  final IconData icon;
  final Color color;
  final bool pulse;

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..repeat(reverse: true);

  late final Animation<double> _scale = Tween(begin: 1.0, end: 1.2).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = Icon(widget.icon, color: widget.color);
    if (!widget.pulse) return icon;

    return ScaleTransition(scale: _scale, child: icon);
  }
}
