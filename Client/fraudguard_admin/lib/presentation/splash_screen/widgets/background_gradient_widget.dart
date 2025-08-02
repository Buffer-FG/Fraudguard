import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class BackgroundGradientWidget extends StatelessWidget {
  final Widget child;

  const BackgroundGradientWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            AppTheme.lightTheme.colorScheme.surface,
            AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.05),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Colors.transparent,
              AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.02),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
