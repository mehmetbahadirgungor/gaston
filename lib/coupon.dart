import 'package:flutter/material.dart';
import 'package:gaston/utils/constants/sizes.dart';
import 'Common/Widgets/Appbar/appbar.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: TAppBar(title: Text('My Coupons', style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// -- Coupons

      ),
    );
  }
}