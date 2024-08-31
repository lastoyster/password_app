import 'dart:js_interop_unsafe';

import 'package:dio/dio.dart';

class  API{
  static const BASE_URL='URL';

  late Dio dio;
  int? userId;

  API(){
    dio = Dio();
    dio.options.BASE_URL;
    dio.options.sendTimeout= 10000;
    dio.interceptions.add(
      InterceptorsWrapper(
        onRequest:(options,handler)=> 
        requestInterception(options,handler),
        onResponse:(response,handler)=> responseInterceptor(response,handler)
        onError:(error,handler)=>errorInterception(error,handler),
    )
    );
}

setUserId(userId){
  this.userId= userId;
  dio.options.baseUrl = BASE_URL + '/users/$userId';
}

clearUserId(){
  this.userId = -1;
  dio.options.baseUrl = BASE_URL;
}

setHeaders(headers){
  dio.options.headers['cookie']= headers;
}

requestInterceptor(
  RequestOptions options,
  RequestInterceptorHandler handler){
    print(options.uri);
    print(options.data);
    handler.next(options);
  }

  responseInterceptor(response,ResponseInterceptor handler){
    print(response.data);
    handler.next(response);
  }

  errorInterceptor(error,ErrorInterceptorHandler handler){
    print(error.message);
    handler.next(error);
  }

  Future test(){
    return dio.get('/test');
  }

  Future signUp(jsonForSignUp){
    return dio.post('/register',data:data);
  }

  Future logIn(data){
    return dio.post('/login',data:data);
  }

  Future requestSmsOtp(){
    return dio.get('/hotp');
  }

  Future checkSmsOtp(data){
    return dio.get('/totp');
  }

  Future checkGoogleOtp(data){
      return dio.post('/totp',data:data);
  }

Future getAllAccounts(){
  return dio.get('/accounts');
}

Future addAccount(data){
  return dio.post('/accounts',data:data);
}

Future updateAccount(accountId,data){
  return dio.put('/accounts/$accountId',data:data);
}

Future deleteAccunt(accountId){
  return dio.delete('/accounts/$accountId');
}

Future getNotificationFreq(){
  return dio.get('/freq');
}

Future changeNotificationFreq(int freq){
  return dio.put('/freq/$freq');
}

Future changeHint(data){
  return dio.put('/hint',data:data);
}

Future changePassword(data){
  return dio.post('/changePassword',data:data);
}
}