import 'package:flutter/material.dart';
import '../../UI/ui.dart';

class OtpNumber extends StatelessWidget {
  final String otp;
  static const int numberOfDigits = 6;

  const OtpNumber({
    required this.otp,
    Key? key,
  }) : super(key: key);

  Color getDigitColor(int digitIndex) {
    return (digitIndex < otp.length)
        ? Palette.primaryDark
        : Palette.secondaryDark;
  }

  String replaceDigitWithDotIfEmpty(int digitIndex) {
    return (digitIndex < otp.length) ? otp[digitIndex] : '•';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numberOfDigits, (index) {
        final color = getDigitColor(index);
        final digit = replaceDigitWithDotIfEmpty(index);
        return digitWidget(digit, color);
      }),
    );
  }

  Widget digitWidget(String digit, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            digit,
            style: TextStyle(
              color: color,
              fontSize: Font.h2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 3.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }
}
