import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/password_policy.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  Widget _buildItem(String text, bool valid) {
    return Row(
      children: [
        Icon(
          valid ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 16,
          color: valid ? AppColors.success : AppColors.textSecondary,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: valid ? AppColors.success : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildItem(
          "At least ${PasswordPolicy.minLength} characters",
          PasswordPolicy.hasMinLength(password),
        ),
        _buildItem("Uppercase letter", PasswordPolicy.hasUppercase(password)),
        _buildItem("Lowercase letter", PasswordPolicy.hasLowercase(password)),
        _buildItem("Numeric character", PasswordPolicy.hasNumber(password)),
        _buildItem(
          "Special character",
          PasswordPolicy.hasSpecialChar(password),
        ),
      ],
    );
  }
}
