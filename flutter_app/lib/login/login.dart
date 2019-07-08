import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/common/tool/ZSHttp.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';
import 'package:flutter_app/common/config.dart';
class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: new Image.asset('assets/logo.jpg'),
              )
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('用户名'),
                  TextField(
                    decoration: InputDecoration(
                        labelText: '请输入用户名',
                        border: InputBorder.none
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Color.fromRGBO(245, 245, 245, 1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('密码'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: '请输入密码',
                        border: InputBorder.none,
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Color.fromRGBO(245, 245, 245, 1),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                ZSHttp.getInstance().post(url: '/token',data: {
                  'usercode': 'admin',
                  'password':'8888'
                }, callBack: (r){
                  print(r);
                  ZSTool.getInstance().setShareDataString(key: kToken,value: r.data['content']);
                  ZSTool.getInstance().setShareDataString(key: kTerm,value: r.data['term']);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return MainPage();
                  },fullscreenDialog: true));
                });
              },
              child: Container(
                width: ScreenUtil.getInstance().setWidth(660),
                height: 50,
                alignment: Alignment.center,
                child: Text('登陆',style: TextStyle(fontSize: 17),),
              ),
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            )
          ],
        ),
      ),
    );
  }
}