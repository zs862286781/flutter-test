import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';

class ConfirmPop extends StatelessWidget {
  final int type; //传入0/1，0：没有输入框的，1：有输入框的
  final String title;
  final void Function(String) sure;
  String rejected = '';
  ConfirmPop({this.type,this.title,this.sure});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (type == 0) {
      return Center(
        child: Container(
          width: ScreenUtil.getInstance().setWidth(650),
          constraints: BoxConstraints(
              maxHeight: 130
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6)
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(title,style: TextStyle(
                    inherit: false,
                    color: Color.fromRGBO(33, 33, 33, 1),
                    fontSize: 17
                ),),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: FlatButton(
                      onPressed: (){
                        sure('');
                        Navigator.pop(context);
                      },
                      color: Colors.blue,
                      highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(0),
                      child: Container(
                        width: 145,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text('确定'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      color: Colors.blue,
                      highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(0),
                      child: Container(
                        width: 145,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text('取消'),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }else {
      return Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        body: Center(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(650),
            constraints: BoxConstraints(
                maxHeight: 260
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(title,style: TextStyle(
                      inherit: false,
                      color: Color.fromRGBO(33, 33, 33, 1),
                      fontSize: 17
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    height: 100,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.blue,
                            width: 2
                        )
                    ),
                    child: TextField(
                        onChanged: (s) {
                          rejected = s;
                        },
                        onSubmitted: (s) {
                        },
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '请输入驳回原因...',
                            contentPadding: EdgeInsets.all(5)
                        )
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: FlatButton(
                        onPressed: (){
                          if (rejected == '') {
                            ZSTool.getInstance().showToast('请输入驳回理由');
                          }else {
                            sure('');
                            Navigator.pop(context);
                          }
                        },
                        color: Colors.blue,
                        highlightColor: Colors.blue[700],
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(0),
                        child: Container(
                          width: 145,
                          height: 30,
                          alignment: Alignment.center,
                          child: Text('确定'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        color: Colors.blue,
                        highlightColor: Colors.blue[700],
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(0),
                        child: Container(
                          width: 145,
                          height: 30,
                          alignment: Alignment.center,
                          child: Text('取消'),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
