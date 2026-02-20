import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth_controller.dart';
import '../../../main.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Delete Account")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            final confirm = await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Confirm Delete"),
                content: const Text("This action cannot be undone. Continue?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Delete"),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              await auth.deleteAccount(
                email: emailController.text,
                password: passwordController.text,
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MyApp()),
                (route) => false,
              );
            }
          },
          child: const Text("Delete My Account"),
        ),
      ),
    );
  }
}
