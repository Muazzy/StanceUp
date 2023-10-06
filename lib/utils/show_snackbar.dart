import 'package:flutter/material.dart';
import 'package:fyp/utils/app_colors.dart';

void showSnackBar(BuildContext context, String text) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryColor,
        content: Text(
          text,
          style: const TextStyle(color: AppColors.secondaryColor),
        ),
      ),
    );
  }
}
