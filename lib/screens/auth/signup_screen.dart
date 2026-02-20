import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../controllers/auth_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            label: const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            icon: const Icon(
              Icons.login_outlined,
              size: 16,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: const SignupForm(),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Password validation flags
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePasswordLive);
  }

  void _validatePasswordLive() {
    final password = _passwordController.text;

    setState(() {
      hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      hasLowercase = RegExp(r'[a-z]').hasMatch(password);
      hasNumber = RegExp(r'[0-9]').hasMatch(password);
      hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
      hasMinLength = password.length >= 8;
    });
  }

  bool get isPasswordValid =>
      hasUppercase &&
      hasLowercase &&
      hasNumber &&
      hasSpecialChar &&
      hasMinLength;

  Widget _requirementItem(String text, bool valid) {
    return Row(
      children: [
        Icon(
          valid ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 16,
          color: valid ? Colors.green : AppColors.textSecondary,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: valid ? Colors.green : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePasswordLive);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    return Container(
      width: 440,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 30,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// NAME
            AppTextField(
              label: "Full Name",
              controller: _nameController,
              height: 48,
              prefixIcon: const Icon(
                Icons.person_outline,
                size: 18,
                color: AppColors.primary,
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Full name required" : null,
            ),

            /// EMAIL
            AppTextField(
              label: "Email Address",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              height: 48,
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: 18,
                color: AppColors.primary,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email required";
                }
                if (!RegExp(
                  r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                ).hasMatch(value)) {
                  return "Invalid email";
                }
                return null;
              },
            ),

            /// PASSWORD
            AppTextField(
              label: "Password",
              controller: _passwordController,
              obscureText: _obscurePassword,
              height: 48,
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 18,
                color: AppColors.primary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              validator: (value) {
                if (!isPasswordValid) {
                  return "Password does not meet requirements";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            /// PASSWORD POLICY CHECKLIST
            _requirementItem("Minimum 8 characters", hasMinLength),
            _requirementItem("Uppercase letter (A-Z)", hasUppercase),
            _requirementItem("Lowercase letter (a-z)", hasLowercase),
            _requirementItem("Number (0-9)", hasNumber),
            _requirementItem("Special character (!@#\$...)", hasSpecialChar),

            const SizedBox(height: 20),

            /// CONFIRM PASSWORD
            AppTextField(
              label: "Confirm Password",
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              height: 48,
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 18,
                color: AppColors.primary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              validator: (value) => value != _passwordController.text
                  ? "Passwords do not match"
                  : null,
            ),

            const SizedBox(height: 16),

            if (auth.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  auth.error!,
                  style: const TextStyle(color: AppColors.error, fontSize: 13),
                ),
              ),

            const SizedBox(height: 10),

            /// SIGN UP BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: auth.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          auth.register(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        }
                      },
                child: auth.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
