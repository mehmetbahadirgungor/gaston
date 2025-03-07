import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../../rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(TImages.userProfileImage1)),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text('Jessica Alba', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Review
        Row(
          children: [
            const TRatingBarIndicator(rating: 5),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('05 April, 2024', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        const ReadMoreText(
          'It was first time for me to buy a fuel on app like this. '
              ' As someone who is not experienced using this kind of app before,'
              ' I was worried at first but later everything went smoothly.'
              ' Whole processes was really clear also they helped me to deal with parts I do not get.'
              ' After purchasing fuel, it arrived within 10 minutes and it was high quality.'
              ' Definitely will recommend to my friends.'
              ' I am really glad for choosing this app',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Company Reviews
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("GASTON Store", style: Theme.of(context).textTheme.bodyLarge),
                    Text('05 April, 2024', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                const ReadMoreText(
                  'Thanks for your comment. We are glad that you are satisfied!',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' show more',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}