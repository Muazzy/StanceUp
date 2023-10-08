import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/services/auth_repository.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/widgets/custom_textfield.dart';
import 'package:fyp/widgets/dont_have_acc.dart';
import 'package:fyp/widgets/sign_in_and_get_started_button.dart';
import 'package:fyp/widgets/social_button.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<AuthRepository>().isLoading;
    return Scaffold(
      resizeToAvoidBottomInset: true, //to make the textFormFields in view
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 10),
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
                'Welcome Back',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
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
                buttonText: 'Sign in',
                isLoading: isLoading,
                fullWidth: true,
                buttonBgColor: AppColors.primaryColor,
                buttonFontColor: Colors.white,
                onPressed: () async {
                  context.read<AuthRepository>().loginWithEmail(
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
                leadingText: "Don't have an account? ",
                buttonText: 'Sign Up',
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
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
