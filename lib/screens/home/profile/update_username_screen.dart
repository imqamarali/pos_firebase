import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth_controller.dart';

class UpdateUsernameScreen extends StatefulWidget {
  const UpdateUsernameScreen({super.key});

  @override
  State<UpdateUsernameScreen> createState() => _UpdateUsernameScreenState();
}

class _UpdateUsernameScreenState extends State<UpdateUsernameScreen> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Update Username")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(labelText: "New Username"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter username" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await auth.updateEmail(controller.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
