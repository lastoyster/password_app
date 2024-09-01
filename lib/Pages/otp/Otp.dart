import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import '../../Pages/otp/otp.dart';
import '../../Pages/pages.dart';
import '../../Services/services.dart';
import '../../UI/ui.dart';
import '../../Widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Otp extends StatefulWidget {
  static const int maxNumberOfTries = 3;

  final String otpType;
  final bool otpForSignUp;

  const Otp({
    this.otpType = CurrentUser.smsOtp,
    this.otpForSignUp = false,
    Key? key,
  }) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late CurrentUser user;
  bool isLoading = false;
  String otp = '';
  int tries = 0;

  @override
  void initState() {
    super.initState();
    user = Provider.of<CurrentUser>(context, listen: false);
  }

  void turnLoadingOn() {
    setState(() {
      isLoading = true;
    });
  }

  void turnLoadingOff() {
    setState(() {
      isLoading = false;
    });
  }

  void otpController(String input) {
    setState(() {
      otp = input;
    });
  }

  Future<void> resendOtp() async {
    turnLoadingOn();
    bool success = await user.requestOtpOfType(widget.otpType);
    if (success) {
      Toast.showDone(context);
    } else {
      Toast.showSomethingWentWrong(context);
    }
    turnLoadingOff();
  }

  void toastNumberOfLeftTries(int numberOfLeftTries) {
    if (numberOfLeftTries <= 0) {
      Toast.showInfo(context, 'Try tomorrow');
    } else if (numberOfLeftTries == 1) {
      Toast.showInfo(context, 'You have one try left');
    } else {
      Toast.showInfo(context, 'You have two tries left');
    }
  }

  void checkNumberOfLeftTries() {
    int numberOfLeftTries = Otp.maxNumberOfTries - tries;
    toastNumberOfLeftTries(numberOfLeftTries);
  }

  Future<void> confirmOtp() async {
    if (otp.length < 6 || tries >= Otp.maxNumberOfTries) return;
    tries++;
    turnLoadingOn();
    bool success = await user.checkOtpOfType(widget.otpType, otp);
    if (!success) {
      checkNumberOfLeftTries();
    } else {
      await navigate();
    }
    turnLoadingOff();
  }

  Future<void> getGoogleAuthOtp() async {
    final url = user.googleAuthOtpLink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.showSomethingWentWrong(context);
    }
  }

  Future<void> navigate() async {
    if (widget.otpForSignUp) {
      goToSignIn();
    } else {
      await user.getAllAccounts();
      goToHomePage();
    }
  }

  void goToHomePage() {
    Navigator.pushReplacement(
      context,
      CustomTransitions.fadeIn(
        context,
        HomePage(),
      ),
    );
  }

  void goToSignIn() {
    Navigator.pushReplacement(
      context,
      CustomTransitions.fadeIn(
        context,
        SignIn(),
      ),
    );
  }

  void back() {
    Navigator.pushReplacement(
      context,
      CustomTransitions.fadeIn(
        context,
        SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String header = '';
    String subHeader = '';
    if (widget.otpType == CurrentUser.smsOtp) {
      header = 'SMS Message';
      subHeader = 'Check your SMS messages. We’ve sent you the OTP at ${user.phone}.';
    } else {
      header = 'Google Authenticator';
      subHeader = 'Check your Google Authenticator account.';
    }

    return BaseScaffold(
      header: header,
      subHeader: subHeader,
      appBarAction: back,
      isLoading: isLoading,
      widgets: [
        OtpWithKeyboard(otpController: otpController),
        if (widget.otpType == CurrentUser.smsOtp)
          OtherOption(
            action: resendOtp,
            question: 'Didn’t receive any code?',
            otherOption: 'Re-send code',
          ),
      ],
      bottom: FAB(icon: FontAwesome5.check, onPress: confirmOtp),
    );
  }
}
