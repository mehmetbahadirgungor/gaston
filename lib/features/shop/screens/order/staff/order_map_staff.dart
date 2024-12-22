import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:gaston/common/widgets/appbar/appbar.dart';
import 'package:gaston/features/shop/controllers/product/order_controller.dart';
import 'package:gaston/geocoding_repository.dart';
import 'package:gaston/utils/constants/enums.dart';
import 'package:gaston/utils/helpers/cloud_helper_functions.dart';
import 'package:gaston/utils/helpers/scan_qr_code.dart';
import 'package:get/get.dart';
import 'package:gaston/data/repositories/order/order_repository.dart';
import 'package:gaston/map_page.dart';
import 'package:gaston/rounded_container.dart';
import 'package:gaston/utils/constants/colors.dart';
import 'package:gaston/utils/constants/sizes.dart';
import 'package:gaston/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:location/location.dart';

class TOrderMapPageStaff extends StatelessWidget {
  const TOrderMapPageStaff({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    Location location = Location();
    bool onChanged = true;

    return StreamBuilder(
      stream: orderController.orderRepository.fetchProcessingOrderAsStream(), // Stream oluşturuldu.
      builder: (context, snapshot) {
        /// Nothing Found Widget
        final emptyWidget = CircularProgressIndicator();

        /// Helper Function: Handle Loader, No Record or Error Message
        final response = TCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        /// Defining Order (It is not needed but if there are many orders, we call 0 index for it)
        final order = snapshot.data![0];

        // Update the map when the location changes
        // location.onLocationChanged.listen((locationData) async {
        //   final newLocation = GeocodingRepository.geocodeToLocation(
        //       LatLng(locationData.latitude!, locationData.latitude!));
        //   order.staffGeocode = newLocation;

        //   print("Konumumuz: ${order.staffGeocode}");

        //   // Shipping Order
        //   orderController.shippingOrder(order);
        // });

        // When the location is obtained, update the map center
        if (order.status == OrderStatus.shipped && onChanged) {
          location.getLocation().then((locationData) {
          final newLocation = GeocodingRepository.geocodeToLocation(
              LatLng(locationData.latitude!, locationData.longitude!));
          order.staffGeocode = newLocation;
          });

          // Shipping Order (Delaying for stream)
          Future.delayed(Duration(seconds: 10), () {
            if (onChanged) orderController.updateStaffLocation(order);
          });
        }

        print("Problem ne abi?");

        return Column(
          children: [
            /// Order Status
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

            // Confirm for shipping
            if (order.status == OrderStatus.processing)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                      child: ElevatedButton(
                        onPressed: () {
                          // When the location is obtained, update the map center
                          location.getLocation().then((locationData) {
                            order.staffGeocode =
                                GeocodingRepository.geocodeToLocation(LatLng(
                                    locationData.latitude!,
                                    locationData.longitude!));
                          });
                          
                          // Shipping Order
                          orderController.shippingOrder(order);
                        },
                        child: const Text('We are ready for shipping.'),
                      ),
                    ),
                  ),
                ],
              ),

            /// Live Map
            if (order.status == OrderStatus.shipped) Expanded(child: MapPage(order: order,)),

            /// Button
            if (order.status == OrderStatus.shipped)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                      child: ElevatedButton(
                        onPressed: () {
                          onChanged = false;
                          orderController.confirmOrder(order);
                        },
                        child: const Text('We came to destination.'),
                      ),
                    ),
                  ),
                ],
              ),
            
            /// Scanning QR Code
            if (order.status == OrderStatus.confirming)
             Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => ScanQRCode(order: order, orderController: orderController,)),
                        child: const Text('Scan QR Code'),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
