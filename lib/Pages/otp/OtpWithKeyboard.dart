import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../Pages/otp/otp.dart';

class OtpWithKeyboard extends StatefulWidget {
  final ValueChanged<String> otpController;

  const OtpWithKeyboard({
    required this.otpController,
    Key? key,
  }) : super(key: key);

  @override
  _OtpWithKeyboardState createState() => _OtpWithKeyboardState();
}

class _OtpWithKeyboardState extends State<OtpWithKeyboard> {
  late KeyboardVisibilityController keyboardVisibilityController;
  final FocusNode focusNode = FocusNode();
  String otp = '';

  @override
  void initState() {
    super.initState();
    keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange
        .listen((visible) => onKeyboardChangeState(visible));
  }

  void onKeyboardChangeState(bool visible) {
    if (!visible) {
      focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 50.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              focusNode.requestFocus();
            },
            behavior: HitTestBehavior.translucent,
            child: OtpNumber(otp: otp),
          ),
          InvisibleKeyboard(
            onChange: (input) {
              setState(() {
                otp = input;
              });
              widget.otpController(input);
            },
            focusNode: focusNode,
          ),
        ],
      ),
    );
  }
}
