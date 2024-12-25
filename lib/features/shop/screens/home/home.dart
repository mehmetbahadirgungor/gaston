
import 'package:flutter/material.dart';
import 'package:gaston/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:gaston/features/shop/screens/home/widgets/home_categories.dart';
import 'package:gaston/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/budget_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import '../all_products/all_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// -- Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Heading
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                            title: 'Popular Categories',
                            showActionButton: false,
                            textColor: Colors.white),
                        SizedBox(height: TSizes.spaceBtwItems),

                        /// Categories
                        THomeCategories(),
                      ],
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Promo Slider
                  const TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Heading
                  TSectionHeading(
                    title: 'Gas Products',
                    onPressed: () => Get.to(() => AllProducts(title: 'Popular Products', futureMethod: controller.fetchAllFeaturedProducts(),
                    ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Popular Products
                  Obx(() {
                    if (controller.isLoading.value) return const TVerticalProductShimmer();

                    if (controller.featuredProducts.isEmpty) {
                      return Center(child: Text('No Data Found', style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return TGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}