import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_app/common/config.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';
import 'package:flutter_app/common/tool/EventBus.dart';
import 'package:flutter/services.dart';
typedef HTTPCallBack = void Function(Response r);
class ZSHttp {
  static Dio dio = Dio(BaseOptions(
    baseUrl: BaseUrl,
    contentType: ContentType.json,
    responseType: ResponseType.json
  ));
  static ZSHttp instance = ZSHttp();
  static ZSHttp getInstance() {
//    instance.httpClientCreate();
    return instance;
  }

  httpClientCreate() async {
    print('star');
//    final List<int> certificateChainBytes =
//    (await rootBundle.load('assets/mykey.bks')).buffer.asInt8List();//assets/mykey.cer   assets/mykey.p12 assets/tomcat.cer
//    final List<int> certificateUserChainBytes =
//    (await rootBundle.load('assets/mykey.p12')).buffer.asInt8List();//assets/mykey.cer   assets/mykey.p12 assets/tomcat.cer
////    print(certificateChainBytes);
////    print(certificateUserChainBytes);
//    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
//      client.badCertificateCallback=(X509Certificate cert, String host, int port) => true;
//      SecurityContext sc = SecurityContext.defaultContext;
////      sc.setTrustedCertificatesBytes(certificateUserChainBytes,password: "123456");
////      sc.setTrustedCertificatesBytes(certificateChainBytes);
////      sc.setClientAuthoritiesBytes(certificateChainBytes,password: "123456");
//      sc.usePrivateKeyBytes(certificateUserChainBytes,password: "123456");
//      HttpClient httpClient = new HttpClient(context: sc);
//      return httpClient;
//    };
  }

  Future<Map<String, dynamic>> httpHeader() async {
    var data = await ZSTool.getInstance().getShareDataString(key: kToken);
    return {
      "Content-Type":"application/json;",
      "z-token": data != null ? data : ''
    };
  }

  post({String url,data,HTTPCallBack callBack}) async {
    dio.options.headers = await httpHeader();
    try {
      Response response = await dio.post(url,data: data);
      if (response.statusCode == 200) {
        callBack(response);
      }
      else {
        errorCallBack(response);
      }
    } catch (e) {
      error(e);
    }
  }

  get({String url,data,HTTPCallBack callBack}) async {
//    await httpClientCreate();
    dio.options.headers = await httpHeader();
    try {
      Response response = await dio.get(url,queryParameters: data);
      if (response.statusCode == 200) {
        callBack(response);
      }else {
        errorCallBack(response);
      }
    } catch (e) {
      print(e);
      error(e.toString());
    }
  }

  errorCallBack(Response response) {
    if (response.statusCode == 401) {
      bus.emit(kNeedLogin);
    }else {
    }
  }

  error(e) {
    if (e == 'DioError [DioErrorType.RESPONSE]: Http status error [401]') {
      bus.emit(kNeedLogin);
    }else {

    }
  }

}