import 'package:flutter/material.dart';
import 'package:gaston/features/authentication/controllers/user/user_controller.dart';
import 'package:gaston/features/personalization/screens/settings/settings.dart';
import 'package:gaston/features/shop/screens/order/staff/live_order_staff.dart';
import 'package:gaston/features/shop/screens/order/user/live_order_user.dart';
import 'package:gaston/features/shop/screens/wishlist/wishlist.dart';
import 'package:gaston/utils/constants/enums.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/helpers/helper_functions.dart';
import 'shop/screens/home/home.dart';
import '../utils/constants/colors.dart';

class NavigationController extends GetxController {
  final Rx<int> selectIndex = 0.obs;
  List<Widget> screens = [
    // const HomeScreen(),
    // const OrderStaffScreen(),
    // const FavouriteScreen(),
    // const SettingsScreen(),
  ];

  NavigationController({required this.screens});
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());

    return Obx(() {
      // Eğer kullanıcı bilgisi yükleniyorsa, bir yükleniyor göstergesi gösterin
      if (userController.profileLoading.value) {
        return Scaffold(body: const Center(child: CircularProgressIndicator()));
      }

      final controller = Get.put(NavigationController(screens: [
        const HomeScreen(),
        if (userController.user.value.userType == UserType.staff)
          const OrderStaffScreen(),
        if (userController.user.value.isThereActiveOrder == true)
          const OrderMemberScreen(),
        const FavouriteScreen(),
        const SettingsScreen(),
      ]));
      final darkMode = THelperFunctions.isDarkMode(context);

      return Scaffold(
        bottomNavigationBar: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: 0,
          onDestinationSelected: (index) =>
              controller.selectIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: [
            const NavigationDestination(
                icon: Icon(Iconsax.home), label: 'Home'),
            if (userController.user.value.userType == UserType.staff)
              const NavigationDestination(
                  icon: Icon(Iconsax.box), label: 'Staff Order'),
            if (userController.user.value.isThereActiveOrder == true)
              const NavigationDestination(
                  icon: Icon(Iconsax.box), label: 'Order'),
            const NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'Favourite'),
            const NavigationDestination(
                icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
        body: Obx(() => controller.screens[controller.selectIndex.value]),
      );
    });
  }
}
