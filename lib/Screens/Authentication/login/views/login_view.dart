import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memotask/Screens/Authentication/login/view_models/login_view_model.dart';
import 'package:memotask/Screens/Authentication/login/views/auth_submit_btn.dart';
import 'package:memotask/Screens/Authentication/login/views/authentication_text_feild.dart';
import 'package:memotask/Screens/Authentication/signup/views/signup_view.dart';
import 'package:memotask/Utils/app_size.dart';
import 'package:memotask/components/snakbars.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  void onLogin({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required LoginViewModel viewModel,
  }) async {
    if (emailController.text.startsWith('@') ||
        emailController.text.endsWith('@') ||
        emailController.text.startsWith('.') ||
        emailController.text.endsWith('.') ||
        !emailController.text.contains('@')) {
      showErrorSnackBar(context, "Invalid Email Address");
      return;
    }
    viewModel.setEmail(emailController.text);
    viewModel.setPassword(passwordController.text);
    bool isLoggedIn = await viewModel.login(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      // appBar: AppBarView(
      //   title: 'Login',
      //   showLeading: false,
      // ),
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
                // Welcome to Memotask [EMOJI of WAVING HAND]
                'Welcome to Memotask 👋',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.spacingLarge),
              AuthenticationTextFeildView(
                controller: emailController,
                onChanged: (value) {
                  viewModel.setEmail(value);
                },
                hintText: 'Email',
                icon: const Icon(Icons.alternate_email),
                height: AppSizes.textFieldHeightMedium,
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              AuthenticationTextFeildView(
                controller: passwordController,
                onChanged: (value) {
                  viewModel.setPassword(value);
                },
                hintText: 'Password',
                icon: const Icon(Iconsax.lock_1),
                isPassword: true,
              ),
              const SizedBox(height: AppSizes.spacingMedium),
              AuthSubmitButton(
                onPressed: () => onLogin(
                  context: context,
                  emailController: emailController,
                  passwordController: passwordController,
                  viewModel: viewModel,
                ),
                lable: 'Login',
                width: AppSizes.getDeviceWidth(context),
                height: AppSizes.buttonHeightMedium,
                isloading: viewModel.isLoading,
              ),
              const SizedBox(height: AppSizes.spacingSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
                    },
                    child: Text(
                      // make one [EMOJI]
                      'Make one 🚀',
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
