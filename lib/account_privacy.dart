import 'package:flutter/material.dart';
import 'package:gaston/utils/constants/sizes.dart';
import 'Common/Widgets/Appbar/appbar.dart';

class AccountPrivacyScreen extends StatelessWidget {
  const AccountPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: TAppBar(title: Text('Account Privacy', style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// -- Text
        child: Text('Privacy Policy'
            '\n\n'
            'Effective Date: 14.12.2024'
            '\n'
            'At Gaston, we are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your personal information when you use our fuel delivery services through the app.'
            '\n\n'
            '1. Information We Collect'
            ' When you create an account with us, we may collect the following types of information:'
            ' Personal Information: This may include your name, email address, phone number, and billing details.'
            ' Location Data: To ensure timely and accurate delivery, we collect your device\'s location information.'
            ' Payment Information: For processing transactions, we may collect payment details such as credit/debit card numbers or other financial data.'
            ' Usage Information: We collect data about your usage of the app, including your preferences, order history, and interactions with the app.'
            '\n\n'
            '2. How We Use Your Information'
            ' We use the information we collect for the following purposes:'
            ' To provide and deliver fuel delivery services'
            ' To process payments securely'
            ' To communicate with you regarding orders, promotions, or updates related to the app'
            ' To improve and personalize your user experience'
            ' To comply with legal obligations'
            '\n\n'
            '3. Data Security'
            ' We take the security of your personal information seriously. We employ industry-standard encryption methods and secure servers to protect your data from unauthorized access, alteration, or disclosure.'
            '\n\n'
            '4. Data Sharing'
            ' We do not sell or rent your personal information to third parties. However, we may share your data with trusted partners who assist in operating the app, processing payments, or delivering services, but only to the extent necessary for these purposes.'
            '\n\n'
            '5. Your Rights and Choices'
            ' You have the right to:'
            '\n\n'
            ' Access, update, or delete your personal information'
            ' Opt-out of marketing communications'
            ' Control location sharing and permissions through your device settings'
            '6. Changes to This Privacy Policy'
            ' We may update this Privacy Policy from time to time. Any changes will be reflected in the updated version of this document, with an updated effective date. We encourage you to review this policy regularly to stay informed about how we protect your privacy.'
            '\n\n'
            '7. Contact Us'
            ' If you have any questions or concerns about this Privacy Policy, please contact us at gaston@gmail.gmail.com.'
            '\n\n'
            ' By using our app, you consent to the collection and use of your personal information as described in this policy.'
            ),
      ),
    );
  }
}