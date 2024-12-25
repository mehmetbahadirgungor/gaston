import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gaston/features/shop/controllers/product/cart_controller.dart';
import 'package:gaston/features/shop/controllers/product/checkout_controller.dart';
import 'package:gaston/features/shop/models/order_model.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../navigation_menu.dart';
import '../../../personalization/controllers/address_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  ///  Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing your order', TImages.pencilAnimation);

      // Get user authentication ID
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        staffId: '',
        staffGeocode: null,
        isActive: true,
      );

      // Save the order
      await orderRepository.saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();

      // Update the user station //TODO: user_repository'e encapsulation yap, buraya ekle.
      FirebaseFirestore.instance.collection("Users").doc(userId).update({'isThereActiveOrder' : true});

      // Show Success screen
      Get.off(() =>
          SuccessScreen(
            image: TImages.orderCompletedAnimation,
            title: 'Payment Success!',
            subTitle: 'Your fuel will be processed soon!',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void chooseOrder(OrderModel order) async {
    // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing your order', TImages.pencilAnimation);
    
    // Get user authentication ID
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

    // Add Details
      final updatedOrder = OrderModel(
        id: order.id,
        userId: order.userId,
        status: OrderStatus.processing,
        totalAmount: order.totalAmount,
        orderDate: order.orderDate,
        paymentMethod: order.paymentMethod,
        deliveryDate: order.deliveryDate,
        address: order.address,
        items: order.items,
        staffId: userId,
        staffGeocode: order.staffGeocode,
        isActive: order.isActive,
      );

    // Update the order
      await orderRepository.updateOrder(updatedOrder, updatedOrder.userId);

    // Update the user station //TODO: user_repository'e encapsulation yap, buraya ekle.
      FirebaseFirestore.instance.collection("Users").doc(userId).update({'isThereActiveOrder' : true});
    
    // Show Success screen
      Get.off(() =>
          SuccessScreen(
            image: TImages.orderCompletedAnimation,
            title: 'Choosing Success!',
            subTitle: 'The order is processed!',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
  }
  
  void shippingOrder(OrderModel order) async {
    // Add Details
      final updatedOrder = OrderModel(
        id: order.id,
        userId: order.userId,
        status: OrderStatus.shipped,
        items: order.items,
        totalAmount: order.totalAmount,
        orderDate: order.orderDate,
        paymentMethod: order.paymentMethod,
        address: order.address,
        deliveryDate: null,
        staffId: order.staffId,
        staffGeocode: order.staffGeocode,
        isActive: order.isActive,
      );

    // Update the order
      await orderRepository.updateOrder(updatedOrder, updatedOrder.userId);
  }

  void updateStaffLocation(OrderModel order) async {
    // Add Details
      final updatedOrder = OrderModel(
        id: order.id,
        userId: order.userId,
        status: order.status,
        items: order.items,
        totalAmount: order.totalAmount,
        orderDate: order.orderDate,
        paymentMethod: order.paymentMethod,
        address: order.address,
        deliveryDate: null,
        staffId: order.staffId,
        staffGeocode: order.staffGeocode,
        isActive: order.isActive,
      );

    // Update the order
      await orderRepository.updateOrder(updatedOrder, updatedOrder.userId);
  }

  void confirmOrder(OrderModel order) async {
    // Add Details
      final updatedOrder = OrderModel(
        id: order.id,
        userId: order.userId,
        status: OrderStatus.confirming,
        items: order.items,
        totalAmount: order.totalAmount,
        orderDate: order.orderDate,
        paymentMethod: order.paymentMethod,
        address: order.address,
        deliveryDate: null,
        staffId: order.staffId,
        staffGeocode: order.staffGeocode,
        isActive: order.isActive,
      );

    // Update the order
      await orderRepository.updateOrder(updatedOrder, updatedOrder.userId);
  }

  void completeOrder(OrderModel order) async { //TODO: Sipariş tamamlama.
    // Add Details
      final updatedOrder = OrderModel(
        id: order.id,
        userId: order.userId,
        status: OrderStatus.delivered,
        totalAmount: order.totalAmount,
        orderDate: order.orderDate,
        paymentMethod: order.paymentMethod,
        address: order.address,
        deliveryDate: DateTime.now(),
        items: order.items,
        staffId: order.staffId,
        isActive: order.isActive,
      );

    // Update the user and staff station //TODO: user_repository'e encapsulation yap, buraya ekle.
      FirebaseFirestore.instance.collection("Users").doc(updatedOrder.userId).update({'isThereActiveOrder' : false});
      FirebaseFirestore.instance.collection("Users").doc(updatedOrder.staffId).update({'isThereActiveOrder' : false});

    // Update the order
      await orderRepository.updateOrder(updatedOrder, updatedOrder.userId);

    // Show Success screen
      Get.off(() =>
          SuccessScreen(
            image: TImages.orderCompletedAnimation,
            title: 'Payment Success!',
            subTitle: 'Your fuel was delivered successfully!',
            onPressed: () => Get.offAll(() async {
              updatedOrder.isActive = false;
              await orderRepository.updateOrder(updatedOrder, updatedOrder.userId);
              return const NavigationMenu();}),
          ));
  } 
}



