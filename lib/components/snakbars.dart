import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memotask/Utils/app_size.dart';
import 'package:memotask/Utils/const_colors.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Iconsax.forbidden,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: AppSizes.iconSize,
          ),
          const SizedBox(width: AppSizes.spacingSmall),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      dismissDirection: DismissDirection.down,
      backgroundColor: AppColors.error,
      hitTestBehavior: HitTestBehavior.deferToChild,
      actionOverflowThreshold: 0.5,
      // show from top
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        left: AppSizes.marginSmall,
        right: AppSizes.marginSmall,
        bottom: AppSizes.marginSmall,
      ),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Iconsax.tick_circle,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: AppSizes.iconSize,
          ),
          const SizedBox(width: AppSizes.spacingSmall),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      dismissDirection: DismissDirection.down,
      backgroundColor: AppColors.success,
      hitTestBehavior: HitTestBehavior.deferToChild,
      actionOverflowThreshold: 0.5,
      // show from top
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        left: AppSizes.marginSmall,
        right: AppSizes.marginSmall,
        bottom: AppSizes.marginSmall,
      ),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

void showWarningSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Iconsax.warning_2,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: AppSizes.iconSize,
          ),
          const SizedBox(width: AppSizes.spacingSmall),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      dismissDirection: DismissDirection.down,
      backgroundColor: AppColors.warning,
      hitTestBehavior: HitTestBehavior.deferToChild,
      actionOverflowThreshold: 0.5,

      // show from top
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        left: AppSizes.marginSmall,
        right: AppSizes.marginSmall,
        bottom: AppSizes.marginSmall,
      ),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
