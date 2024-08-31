import 'package:flutter/material.dart';
import 'package:password_app/UI/ui.dart';

class OtherOption extends StatelessWidget {
  final VoidCallback action; // Use VoidCallback for a function with no arguments and no return value
  final String question;
  final String otherOption; // Variable names should start with a lowercase letter

  OtherOption({
    required this.action,
    required this.question,
    required this.otherOption,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: RichText( // Fixed typo from 'RechinText' to 'RichText'
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: Font.h4), // Make sure 'Font.h4' is defined in your 'ui.dart'
          children: [
            TextSpan(
              text: '$question\n',
              style: const TextStyle(
                color: Palette.secondaryDark, // Assuming 'Palette' is defined in 'ui.dart'
              ),
            ),
            TextSpan(
              text: otherOption, // Use the correct variable name
              style: const TextStyle(
                color: Palette.primaryDark, // Assuming 'Palette' is defined in 'ui.dart'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
