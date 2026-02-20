import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../main.dart';
import 'cart_tab.dart';
import 'home_tab.dart';
import 'profile_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "POS Store",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            elevation: 0,
            actions: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      controller.changeTab(1);
                    },
                  ),
                  if (controller.cartCount > 0)
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        controller.cartCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  context.read<AuthController>().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MyApp()),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ],
          ),
          body: _buildBody(controller),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(HomeController controller) {
    switch (controller.currentIndex) {
      case 0:
        return HomeTab(controller: controller);
      case 1:
        return CartTab(controller: controller);
      case 2:
        return const ProfileTab();
      default:
        return const SizedBox();
    }
  }
}
