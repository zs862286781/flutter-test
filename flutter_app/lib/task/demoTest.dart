import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';
import 'package:flutter_app/common/config.dart';
class DemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  static const MethodChannel methodChannel = MethodChannel('samples.flutter.io/battery');
  Map result;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("功能概览"),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: FlatButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onPressed: () async {
                try {
                  final Map re = await methodChannel.invokeMethod('getLocation');
                  print(re['formattedAddress']);
                  setState(() {
                    result = re;
                  });
//                  await methodChannel.invokeMethod('goMap');
                } on PlatformException {
                }
              },
              child: Container(
                height: 50,
                child: Text("获取定位",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),),
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(result == null ? "" : result['formattedAddress'].toString()),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: FlatButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onPressed: () async {
                try {
                  await methodChannel.invokeMethod('goMap',result);
                } on PlatformException {
                }
              },
              child: Container(
                height: 50,
                child: Text("地图展示",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),),
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: FlatButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onPressed: () async {
                try {
                  final token = await ZSTool.getInstance().getShareDataString(key: kToken);
                  await methodChannel.invokeMethod('openOffice',token);
                } on PlatformException {
                }
              },
              child: Container(
                height: 50,
                child: Text("文档打开",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),),
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}