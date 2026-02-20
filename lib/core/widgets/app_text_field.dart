import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final double? width;
  final double height;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.width,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);

    double fieldWidth;

    if (width != null) {
      fieldWidth = width!;
    } else if (breakpoint.isMobile) {
      fieldWidth = double.infinity;
    } else if (breakpoint.isTablet) {
      fieldWidth = 400;
    } else {
      fieldWidth = 450;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: fieldWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obscureText,
                validator: validator,
                readOnly: readOnly,
                onTap: onTap,
                maxLines: maxLines,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),

                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,

                  // 🔥 Important: Prevents height jump
                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
