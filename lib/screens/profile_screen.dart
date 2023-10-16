import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/widgets/sign_in_and_get_started_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../services/auth_repository.dart';

// import 'package:fyp/auth_repository.dart'; // Import your AuthRepository
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final userId = AuthRepository.currentUserUid;
    final userData = await context.read<AuthRepository>().getUserInfo(userId);

    setState(() {
      userInfo = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<AuthRepository>().isLoading;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primaryColor,
                child: Expanded(
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                userInfo['name'] ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userInfo['email'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              SignInAndGetStartedButton(
                buttonText: 'Logout',
                isLoading: isLoading,
                fullWidth: true,
                buttonBgColor: AppColors.primaryColor,
                buttonFontColor: Colors.white,
                onPressed: () async {
                  context.read<AuthRepository>().signOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
