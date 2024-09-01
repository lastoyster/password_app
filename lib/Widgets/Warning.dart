import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:password_app/UI/ui.dart';


class Warning extends StatelessWidget {
  final String warning;

  const Warning({
    required this.warning,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 96.0,
      child: AutoSizeText(
        warning,
        style: const TextStyle(
          color: Palette.primaryDark,
          fontSize: Font.h4,
          fontWeight: FontWeight.w700,
        ),
        maxLines: 2,
      ),
    );
  }
}