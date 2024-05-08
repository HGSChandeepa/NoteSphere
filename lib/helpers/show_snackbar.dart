import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppHelpers {
//methode to show a snackbar

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFabColor,
        content: Text(
          message,
          style: AppTextStyles.appButton,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
