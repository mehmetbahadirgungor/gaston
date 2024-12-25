
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/loaders/animation_loader.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/product/favourites_controller.dart';
import '../home/home.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());//FavouritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title:
        Text('Favourite', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
        ],
        showBackArrow: false,
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),

          /// Products Grid
          child: Column(
            children: [
              Obx(
                    () => FutureBuilder(
                    future: controller.favoriteProducts(),
                    builder: (context, snapshot) {
                      /// Nothing Found Widget
                      final emptyWidget = TAnimationLoaderWidget(
                        text: "You don't have a favourite product yet.",
                        animation: TImages.pencilAnimation,
                        showAction: true,
                        actionText: 'Let\'s add some',
                        onActionPressed: () => Get.off(() => const HomeScreen()),//const NavigationMenu()),
                      );

                      const loader = TVerticalProductShimmer(itemCount: 6);
                      final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                      if (widget != null) return widget;

                      final products = snapshot.data!;
                      return TGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => TProductCardVertical(product: products[index]));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}