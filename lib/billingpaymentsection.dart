import 'package:flutter/material.dart';
import 'package:gaston/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class BillingPaymentSectionScreen extends StatelessWidget {
  const BillingPaymentSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: TAppBar(title: Text('Bank Account', style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// -- Methods
        child: SingleChildScrollView(child: TBillingPaymentSection()),
      ),
    );
  }
}