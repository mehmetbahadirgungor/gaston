import 'package:flutter/material.dart';
import 'package:gaston/features/authentication/controllers/user/user_controller.dart';
import 'package:gaston/features/shop/screens/order/staff/order_map_staff.dart';
import 'package:gaston/features/shop/screens/order/user/order_map_user.dart';
import 'package:gaston/features/shop/screens/order/widgets/orders_list_user.dart';
import 'package:gaston/map_page.dart';
import 'package:gaston/utils/constants/enums.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';

class OrderStaffScreen extends StatelessWidget {
  const OrderStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final isThereActiveOrder = userController.user.value.isThereActiveOrder;
    final userType = userController.user.value.userType;
    return Scaffold(
      /// -- AppBar
      appBar: TAppBar(title: Text('Pending Orders', style: Theme.of(context).textTheme.headlineMedium), showBackArrow: false,),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),

        /// -- Orders //TODO: Güncel Order dönecek.
        child: isThereActiveOrder == true ? TOrderMapPageStaff() : SingleChildScrollView(child: TOrderStaffListItems())
      ),
    );
  }
}