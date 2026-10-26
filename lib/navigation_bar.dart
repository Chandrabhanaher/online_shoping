import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _NavigationMenu();
}

class _NavigationMenu extends State<Home> {
  final controller = Get.put(NavigateController());

  static const _destinations = [
    _NavigationDestinationData(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    _NavigationDestinationData(
      label: 'Store',
      icon: Icons.storefront_outlined,
      selectedIcon: Icons.storefront,
    ),
    _NavigationDestinationData(
      label: 'Wishlist',
      icon: Icons.favorite_border,
      selectedIcon: Icons.favorite,
    ),
    _NavigationDestinationData(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: controller.selectedIndex.value,
        children: [
          for (final item in _destinations)
            Center(
              child: Text(
                '${item.label} page',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: controller.selectedIndex.value,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() {
            controller.selectedIndex.value = index;
          });
        },
        destinations: [
          for (final item in _destinations)
            NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: item.label,
            ),
        ],
      ),
    );
  }
}

class _NavigationDestinationData {
  const _NavigationDestinationData({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class NavigateController extends GetxController {
  RxInt selectedIndex = 0.obs;
}
