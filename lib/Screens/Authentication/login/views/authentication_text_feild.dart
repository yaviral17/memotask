import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memotask/Utils/app_size.dart';

class AuthenticationTextFeildView extends StatefulWidget {
  const AuthenticationTextFeildView({
    super.key,
    required this.controller,
    this.hintText,
    this.icon,
    this.isPassword = false,
    this.obscureText,
    this.onChanged,
    this.width,
    this.height,
  });

  final TextEditingController controller;
  final String? hintText;
  final Widget? icon;
  final bool isPassword;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final double? width;
  final double? height;

  @override
  State<AuthenticationTextFeildView> createState() =>
      _AuthenticationTextFeildViewState();
}

class _AuthenticationTextFeildViewState
    extends State<AuthenticationTextFeildView> {
  late bool obscureText;
  @override
  void initState() {
    // TODO: implement initState

    obscureText =
        widget.isPassword == true ? true : widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxHeight: widget.height ?? double.infinity,
          maxWidth: widget.width ?? double.infinity,
          minHeight: widget.height ?? AppSizes.textFieldHeight,
          minWidth: widget.width ?? AppSizes.textFieldWidth,
        ),
        hintText: widget.hintText,

        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(obscureText ? Iconsax.eye_slash : Iconsax.eye),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        prefixIcon: widget.icon,
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        // focusColor: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
