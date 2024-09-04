import 'package:flutter/material.dart';
import '../../UI/ui.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Palette.primaryDark),
    );
  }
}