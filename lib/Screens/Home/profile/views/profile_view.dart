import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memotask/Screens/Authentication/login/views/login_view.dart';
import 'package:memotask/Screens/Home/main_navigation_view_model.dart';
import 'package:memotask/Utils/app_size.dart';

class ProfileView extends StatelessWidget {
  ProfileView({
    super.key,
    required this.mainNavigator,
  });
  MainNavigatorViewModel mainNavigator;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UserProfileCardView(),
        const SizedBox(height: AppSizes.spacingMedium),
        //More Options
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
          child: Column(
            children: [
              ProfileScreenOptions(
                onPressed: () {
                  // mainNavigator.pageController.jumpToPage(0);
                },
                lable: "MCQs",
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.9),
                isLogout: false,
              ),
              ProfileScreenOptions(
                onPressed: () {
                  // mainNavigator.pageController.jumpToPage(1);
                },
                lable: "Streaks",
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.9),
                isLogout: false,
              ),
              const ProfileScreenOptions(
                isLogout: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileScreenOptions extends StatelessWidget {
  const ProfileScreenOptions({
    super.key,
    this.onPressed,
    this.minimumSize,
    this.maximumSize,
    this.lable,
    this.icon,
    this.isLogout = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  final void Function()? onPressed;
  final Size? minimumSize;
  final Size? maximumSize;
  final String? lable;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingSmall),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isLogout
                ? Theme.of(context).colorScheme.error.withOpacity(0.9)
                : backgroundColor ?? Theme.of(context).colorScheme.primary,
          ),
          foregroundColor: MaterialStateProperty.all(
            isLogout
                ? Theme.of(context).colorScheme.onPrimary
                : foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(
              AppSizes.getDeviceWidth(context),
              AppSizes.buttonHeightMedium,
            ),
          ),
        ),
        onPressed: isLogout
            ? () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                );
              }
            : onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isLogout ? "Logout" : lable ?? "No Label",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            isLogout
                ? const Icon(Iconsax.logout, size: AppSizes.iconSizeMedium)
                : icon ?? const SizedBox(),

            // SizedBox(width: AppSizes.spacingSmall),
          ],
        ),
      ),
    );
  }
}

class UserProfileCardView extends StatelessWidget {
  const UserProfileCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppSizes.padding,
        right: AppSizes.padding,
        top: AppSizes.paddingLarge,
        bottom: AppSizes.padding,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            blurRadius: AppSizes.shadowBlurRadius,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: AppSizes.circularAvatarSizeLarge,
            child: const Icon(
              Icons.person,
              size: AppSizes.iconSizeLarge,
            ),
          ),
          const SizedBox(width: AppSizes.spacingMedium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FirebaseAuth.instance.currentUser!.displayName ??
                    "Unknown Name",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email ?? "Unknown Email",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          )
        ],
      ),
    );
  }
}
