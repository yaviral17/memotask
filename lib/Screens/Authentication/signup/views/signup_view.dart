import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memotask/Screens/Authentication/login/views/auth_submit_btn.dart';
import 'package:memotask/Screens/Authentication/login/views/authentication_text_feild.dart';
import 'package:memotask/Screens/Authentication/signup/view_models/signup_view_model.dart';
import 'package:memotask/Utils/app_size.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignUpViewModel viewModel = Provider.of<SignUpViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello there!',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              Text(
                'Create an account to get started with us! 🚀',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.spacingMedium),
              AuthenticationTextFeildView(
                controller: nameController,
                hintText: 'Name',
                icon: const Icon(Iconsax.user),
                onChanged: (value) {
                  viewModel.setName(value);
                },
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              AuthenticationTextFeildView(
                controller: emailController,
                hintText: 'Email',
                icon: const Icon(Icons.alternate_email),
                onChanged: (value) {
                  viewModel.setEmail(value);
                },
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              AuthenticationTextFeildView(
                controller: passwordController,
                hintText: 'Password',
                icon: const Icon(Iconsax.lock),
                onChanged: (value) {
                  viewModel.setPassword(value);
                },
                isPassword: true,
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              AuthenticationTextFeildView(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                icon: const Icon(Iconsax.lock),
                onChanged: (value) {
                  viewModel.setConfirmPassword(value);
                },
                isPassword: true,
              ),
              const SizedBox(height: AppSizes.spacingMedium),
              AuthSubmitButton(
                onPressed: () async {
                  bool response = await viewModel.signUp(context: context);
                  if (response) {
                    Navigator.pop(context);
                  }
                },
                lable: 'Sign Up',
                isloading: viewModel.isLoading,
                width: AppSizes.getDeviceWidth(context),
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
