import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  // For SVG support
import 'package:gaston/utils/constants/sizes.dart';  // Assuming these are for padding
import 'Common/Widgets/Appbar/appbar.dart';  // Your custom AppBar

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: TAppBar(
        title: Text('Languages', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),

        /// -- Language Selection Row with Flag and Title
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,  // Ensures proper alignment of the row content
          children: [
            // Flag Icon (using SVG for demonstration, replace with an image if needed)
            SvgPicture.asset(
              'assets/images/flag/GB-flag.png', // Adjust path to your flag SVG
              width: 40, // You can set your flag size here
              height: 40,
            ),
            const SizedBox(width: 10),  // Space between the flag and title
            // Title Text next to the flag
            Text(
              'English',  // Language Title
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 18,  // Adjust the size if necessary
                fontWeight: FontWeight.bold,  // Make the title a bit bolder if you want
              ),
            ),
          ],
        ),
      ),
    );
  }
}
