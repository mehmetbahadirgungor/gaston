
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/loaders/animation_loader.dart';
import '../../../../../data/repositories/order/order_repository.dart';
import '../../../../../rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../navigation_menu.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderRepository());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          /// Nothing Found Widget
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops No Orders yet',
            animation: TImages.orderCompletedAnimation2,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          /// Helper Function: Handle Loader, No Record or Error Message
          final response = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          /// Congrats Record Found
          final orders = snapshot.data!;
          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              separatorBuilder: (_, index) =>
              const SizedBox(height: TSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final order = orders[index];
                return TRoundedContainer(
                  showBorder: true,
                  backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.light,
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
                                  style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 1),
                                ),
                                Text(order.formattedOrderDate, style: Theme.of(context).textTheme.headlineSmall),
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                          style: Theme.of(context).textTheme.labelMedium),
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
                );
              });
        });
  }
}