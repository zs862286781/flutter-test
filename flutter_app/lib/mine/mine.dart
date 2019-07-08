import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/common/tool/EventBus.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';
import 'package:flutter_app/common/config.dart';
class MinePage extends StatefulWidget {
  @override
  MinePageState createState() => MinePageState();
}

class MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('用户中心'),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 5,
            color: Color.fromRGBO(245, 245, 245, 1),
          ),
          Container(
            height: 100,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 100,
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/icon_my_def.png',width: 60,),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('admin',style: TextStyle(fontSize: 16),),
                      ),
                      Text('18888888888',style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 100, 100, 1)))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 50,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(100),
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/ic_passw.jpg',width: ScreenUtil.getInstance().setWidth(60),),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(600),
                  padding: EdgeInsets.only(left: 10),
                  child: Text('修改密码',style: TextStyle(fontSize: 17),),
                ),
                Image.asset('assets/ic_right_arrow.png')
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FlatButton(
          onPressed: () async {
            await ZSTool.getInstance().removeShareData(key: kToken);
            bus.emit(kNeedLogin);
          }, 
          padding: EdgeInsets.all(0),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Container(
            width: ScreenUtil.getInstance().setWidth(690),
            height: 50,
            alignment: Alignment.center,
            child: Text('退出账户',style: TextStyle(color: Colors.white,fontSize: 16),),
          ),
      ),
    );
  }
}