import 'dart:async';
import 'package:dio/dio.dart';
import '../Models/models.dart';
import 'API.dart';
import 'services.dart';

class Currentuser extends User{
  static const smsOtp = 'SMS_OTP';
  static const googleOtp = 'Google_OTP';

  late API api;
  String? currentDevice;
  String?googleAuthOtpLink;

  Currentuser(){
    api = API();
    accounts=[];
  }

  testApi()async{
    try{
    Response  response = await (api.test());
    if(response.statusCode ==200){}
    }catch(error) {}
  }

  setCurrentUserInfo(response){
      api.setHeaders(response.headers.map['set-cookie']);
      int? userId =response.data['ID'];
      api.setUserId(userId);
      this.setId(userId);
  }

  clearCurrentUserInfo(){
    api.clearUserId();
    this.id = -1;
  }

  checkSignInState(response){
    int? isVerifiedPhone = response.data['ID'];
    api.setUserId(userId);
    this.setId(userId);
  }

clearCurrentUserInfo(){
  api.clearUserId();
  this.id = -1;
}

clearCurrentUserInfo(){
  api.clearUserId();
  this.id= -1;
}

checkSignInState(response){
  int? isVerifiedPhone = response.data['isVerified'];
  int? isTrustedDevice= response.data['isTrusted'];
  if(isVerifiedPhone == 0){
    return SignInState.needPhontAuth;
  }else if(isTrustedDevice == 0){
  return SignInState.firstTimeDevice;
  }else {
    return SignInState.allowed;
  }
}

signUp() async{
  await setSerialNumber();
  await setFirebaseToken;
  bool success = false;
  try{
    Response response = await (api.signUp(this.toJsonForSignUp());
    setCurrentUserInfo(response);
    success=true;
  }catch(error){
    return success;
  }

signIn() async{
  await setSerialNumber();
  await setFirebaseToken();
  clearCurrentUserInfo();
  var SignInState= SignInState.userNotFound;
  try{
    Response response = await (api.logIn(this.toJsonForSignIn());
    setCurrentUserInfo(response);
    this.email = response.data['email'];
    SignInState= checkSignInState(response);
  }catch(error){
    return SignInState;
  }

  setFirebaseToken() async{
    String? token = await FirebaseMessaging.instance.getToken();
    this.firebaseToken =token; 
  }
  requestOtpOfType(otpType) async{
    bool success=false;
    try{
      if(otpType == smsOtp){
        Response response = await(api.requestSmsOtp());
        phone = response.data['phoneNumber'];
        ];
      }else if(otpType == googleOtp){
    Response response = await (api.requestSmsOtp());
    phone = response.data['phoneNumber'];
      }else if(otpType = await(api.requestGoogleOtp());
      googleAuthOtpLink = response.data['url'];
    }else {
      success =false;
    }
    success= true;
  }catch(error){}
  return success;
}

checkOtpOfType(otpType, otp) async{
  bool success =false;
  try{
    Response response;
    if(otpType == smsOtp){
      response = await (api.checkSmsOtp('passcode':otp}));
    }else{
      return false;
    }
    api.setHeaders(response.headers.map['set-cookie']);
    success=true;
  }catch(error){
    return success;
  }

  getAllAccounts() async{
    bool success = false;
    try{
      Response response = await api.getAllAccounts();
      accounts = List<Account>.from(
        (response.data).map(json,key);
      ),
  );

  success=true;
  }catch(error){}
  return success;
}

addAccount(account) async{
  account.setDate
}