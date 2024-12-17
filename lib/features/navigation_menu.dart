import 'package:flutter/material.dart';
import 'package:gaston/features/personalization/screens/settings/settings.dart';
import 'package:gaston/features/shop/screens/order/order.dart';
import 'package:gaston/features/shop/screens/wishlist/wishlist.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/helpers/helper_functions.dart';
import 'shop/screens/home/home.dart';
import '../utils/constants/colors.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar:
        NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: 0,
        onDestinationSelected: (index) => controller.selectIndex.value = index,
        backgroundColor: darkMode ? TColors.black : Colors.white,
        indicatorColor:  darkMode ? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1),

        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.box), label: 'Order'),
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
      body: Obx(() => controller.screens[controller.selectIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const OrderScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];
}