import 'package:flutter/material.dart';
import 'package:gaston/common/widgets/appbar/appbar.dart';
import 'package:gaston/common/widgets/success_screen/success_screen.dart';
import 'package:gaston/features/navigation_menu.dart';
import 'package:gaston/features/shop/controllers/product/order_controller.dart';
import 'package:gaston/features/shop/models/order_model.dart';
import 'package:gaston/utils/constants/enums.dart';
import 'package:gaston/utils/constants/image_strings.dart';
import 'package:gaston/utils/helpers/cloud_helper_functions.dart';
import 'package:gaston/utils/helpers/generate_qr_code.dart';
import 'package:get/get.dart';
import 'package:gaston/data/repositories/order/order_repository.dart';
import 'package:gaston/map_page.dart';
import 'package:gaston/rounded_container.dart';
import 'package:gaston/utils/constants/colors.dart';
import 'package:gaston/utils/constants/sizes.dart';
import 'package:gaston/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class TOrderMapPageMember extends StatelessWidget {
  const TOrderMapPageMember({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return StreamBuilder(
      stream: orderController.orderRepository.fetchPendingOrderAsStream(), // Stream oluşturuldu.
      builder: (context, snapshot) {
        /// Nothing Found Widget
        final emptyWidget = CircularProgressIndicator();

        /// Helper Function: Handle Loader, No Record or Error Message
        final response = TCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        /// Defining Order (It is not needed but if there are many orders, we call 0 index for it)
        final order = snapshot.data![0];
        
        if (order.status == OrderStatus.delivered) {
          /// Success Screen
          Get.off(() =>
          SuccessScreen(
            image: TImages.orderCompletedAnimation,
            title: 'Payment Success!',
            subTitle: 'Your fuel was delivered successfully!',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
        }

        return Column(
          children: [
            /// Order Status
            if (order.status != OrderStatus.delivered)
            TRoundedContainer(
              showBorder: true,
              backgroundColor: THelperFunctions.isDarkMode(context) 
                  ? TColors.dark 
                  : TColors.light,
              child: Column(
                children: [
                  /// -- Top Row
                  Row(
                    children: [
                      /// 1 - Image
                      const Icon(Iconsax.truck),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),

                      /// 2 - Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                    color: TColors.primary, 
                                    fontWeightDelta: 1,
                                  ),
                            ),
                            Text(
                              order.formattedOrderDate, 
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// -- Row 2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            /// 1 - Icon
                            const Icon(Iconsax.tag),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),

                            /// 2 - Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.id,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            /// 1 - Icon
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),

                            /// 2 - Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Date',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.formattedDeliveryDate,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Live Map
            if (order.status == OrderStatus.shipped && order.staffGeocode != null) Expanded(child: MapPage(order: order)),

            /// QR Code
            if (order.status == OrderStatus.confirming)
              GenerateQRCode(data: order.qrCode,)
              // TODO: Burdaki buton staff için
              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(TSizes.spaceBtwItems),
              //         child: ElevatedButton(
              //           onPressed: () {},
              //           child: const Text('QR Code'),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            // 
          ],
        );
      },
    );
  }
}
