import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final newPasswordController = TextEditingController();
  final confirmnewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await auth.updatePassword(
                  email: emailController.text.trim(),
                  currentPassword: passwordController.text.trim(),
                  newPassword: newPasswordController.text.trim(),
                );
                Navigator.pop(context);
              },
              child: const Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}
