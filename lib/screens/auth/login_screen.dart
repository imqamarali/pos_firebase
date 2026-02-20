import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../controllers/auth_controller.dart';
import '../../main.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _LoginBody());
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Welcome Back",
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
                MaterialPageRoute(builder: (_) => const SignupScreen()),
              );
            },
            label: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            icon: const Icon(
              Icons.person_add_outlined,
              size: 16,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    return Container(
      width: 420, // ✅ Fixed card width for all platforms
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.point_of_sale, size: 55, color: AppColors.primary),
            const SizedBox(height: 15),

            const Text(
              "POS System Login",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 25),
            AppTextField(
              label: "Email Address",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              height: 45, // ✅ Fixed height
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: 18,
                color: AppColors.primary,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            // PASSWORD FIELD
            AppTextField(
              label: "Password",
              controller: passwordController,
              obscureText: _obscurePassword,
              height: 45, // ✅ Fixed height
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
                if (value == null || value.isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            if (auth.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  auth.error!,
                  style: const TextStyle(color: AppColors.error, fontSize: 13),
                ),
              ),

            // LOGIN BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: auth.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          await auth.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const MyApp()),
                          );
                        }
                      },
                child: auth.isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.background,
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
