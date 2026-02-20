import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../main.dart';
import '../../services/firebase/auth_service.dart';
import 'profile/change_password.dart';
import 'profile/delete_account.dart';
import 'profile/update_username_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final authService = AuthService();
    final user = authService.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          /// USER INFO CARD
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xff4e73df), Color(0xff224abe)],
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? "No Username",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user?.email ?? "",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// SETTINGS OPTIONS
          _profileTile(
            context,
            icon: Icons.edit_outlined,
            title: "Update Username",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UpdateUsernameScreen()),
              );
            },
          ),

          _profileTile(
            context,
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),

          _profileTile(
            context,
            icon: Icons.delete_outline,
            title: "Delete My Account",
            color: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DeleteAccountScreen()),
              );
            },
          ),

          const SizedBox(height: 20),

          _profileTile(
            context,
            icon: Icons.logout,
            title: "Logout",
            color: Colors.orange,
            onTap: () async {
              await context.read<AuthController>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MyApp()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _profileTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
