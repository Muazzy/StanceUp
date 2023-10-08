import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/services/auth_repository.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/widgets/custom_textfield.dart';
import 'package:fyp/widgets/dont_have_acc.dart';
import 'package:fyp/widgets/sign_in_and_get_started_button.dart';
import 'package:fyp/widgets/social_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();

    final TextEditingController nameController = TextEditingController();

    bool isLoading = context.watch<AuthRepository>().isLoading;

    return Scaffold(
      resizeToAvoidBottomInset: true, //to make the textFormFields in view
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Hey there,',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Create an Account',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              //TODO implement this functionality to get name of the user.
              CustomFormField(
                textEditingController: nameController,
                labelText: 'Name',
                isPassword: false,
                primaryColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
              ),
              const SizedBox(height: 24),
              CustomFormField(
                labelText: 'Email',
                isPassword: false,
                textEditingController: emailController,
                primaryColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
              ),
              const SizedBox(height: 24),
              CustomFormField(
                labelText: 'Password',
                isPassword: true,
                textEditingController: passwordController,
                primaryColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
              ),
              const SizedBox(height: 24),
              SignInAndGetStartedButton(
                isLoading: isLoading,
                fullWidth: true,
                buttonText: 'Sign Up',
                buttonBgColor: AppColors.primaryColor,
                buttonFontColor: Colors.white,
                onPressed: () {
                  context.read<AuthRepository>().signUpWithEmail(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        context: context,
                      );
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'or with',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.primaryColor.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButton(
                    iconColor: AppColors.primaryColor,
                    buttonIcon: Icons.access_alarm_outlined,
                    child: SizedBox(
                      width: 24,
                      child: Image.asset(
                        'assets/images/google_icon.png',
                      ),
                    ),
                    onPressed: () {
                      context.read<AuthRepository>().signInWithGoogle(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DontHaveAnAcc(
                leadingText: "Already have an account? ",
                buttonText: 'Sign In',
                onPressed: () {
                  Navigator.pop(context);
                },
                btnColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
