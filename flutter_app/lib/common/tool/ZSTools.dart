import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/common/config.dart';
import 'dart:convert' as convert;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class ZSTool {
   static ZSTool instance = ZSTool();
   static ZSTool getInstance() {
     return instance;
   }
   Future<String> getShareDataString({String key}) async {
     var share = await SharedPreferences.getInstance();
     var value = share.getString(key);
     return value;
   }
   setShareDataString({String key,String value}) async {
     var share = await SharedPreferences.getInstance();
     await share.setString(key, value);
   }
   removeShareData({String key}) async {
     var share = await SharedPreferences.getInstance();
     await share.remove(key);
   }
//   登陆判断
   Future<bool> isLogin() async {
     var token = await getShareDataString(key: kToken);
     return token == null ? false : true;
   }
/*
  * Base64加密
  */
  String base64Encode(String data){
    var content = convert.utf8.encode(data);
    var digest = convert.base64Encode(content);
    return digest;
  }

  showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
/*
  * 通过图片路径将图片转换成Base64字符串
  */
  Future<String> image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return convert.base64Encode(imageBytes);
  }
  /*
  * 将图片文件转换成Base64字符串
  */
  Future<String> imageFile2Base64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return convert.base64Encode(imageBytes);
  }

  /*
  * 将Base64字符串的图片转换成图片
  */
  base642Image(String base64Txt) {
    var imgs = convert.base64.decode(base64Txt);
    Image.memory(imgs);
  }
}