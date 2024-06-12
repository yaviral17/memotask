import 'package:flutter/material.dart';
import 'package:memotask/Utils/app_size.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    this.onPressed,
    this.lable,
    this.width,
    this.height,
    required this.isloading,
  });

  final void Function()? onPressed;
  final String? lable;
  final double? width;
  final double? height;
  final bool isloading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        minimumSize: Size(
          width ?? AppSizes.buttonWidthMedium,
          height ?? AppSizes.buttonHeightMedium,
        ),
        maximumSize: Size(
          width ?? AppSizes.buttonWidthMedium,
          height ?? AppSizes.buttonHeightMedium,
        ),
      ),
      onPressed: onPressed,
      child: isloading
          ? const CircularProgressIndicator()
          : Text(
              lable ?? 'Submit',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
    );
  }
}
