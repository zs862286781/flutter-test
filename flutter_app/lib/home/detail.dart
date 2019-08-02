import 'package:flutter/material.dart';
import 'package:flutter_app/common/config.dart';
import 'package:flutter_app/common/tool/ZSHttp.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';
import 'package:flutter_app/models/detailModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/common/pop/pop.dart';
import 'package:image_picker/image_picker.dart';
//-----------------合同类的详情展示---------------
class BaseDetail extends StatefulWidget {
  final String pageUrl;
  final int id;
  final MenuType type;
  BaseDetail({this.pageUrl,this.id,this.type});
  @override
  BaseDetailState createState() => BaseDetailState();
}

class BaseDetailState extends State<BaseDetail> {
  List<DetailListItem> detailList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData() async {
    String url = '/workflow/' + ZSTool.getInstance().base64Encode(widget.pageUrl) + '/' + widget.id.toString();
    await ZSHttp.getInstance().get(url: url,callBack: (r){
      print(r);
      if (r.data['pmBargainnew'] != null) { //合同
        Map<String, dynamic>data = r.data['pmBargainnew'];
        HeTongModel model = HeTongModel.fromJSON(data);
        updateListWithHeTong(model);
        print(model.bgnname);
      }
      else if (r.data['hrTimecard'] != null) { //考勤
        Map<String, dynamic>data = r.data['hrTimecard'];
        HRModel model = HRModel.fromJSON(data);
        updateListWithHR(model);
      }
      else if (r.data['pmSubplan'] != null) {//分包
        Map<String, dynamic>data = r.data['pmSubplan'];
        FenBaoModel model = FenBaoModel.fromJSON(data);
        if (widget.pageUrl == "webapp/project/subplan/subplan-zb-apply-sh.jsp" ||
            widget.pageUrl == "webapp/project/subplan/subplan-zb-ywbldqz.jsp") {//招标
          updateListWithZhaoBiao(model);
        }else {//分包
          updateListWithFenBao(model);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type.title),
        elevation: 0,
      ),
      backgroundColor: RGB(r: 245,g: 245,b: 245),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    child: FlatButton(
                      onPressed: (){
                        showDialog(context: context,builder: (context){
                          return ConfirmPop(type: 0,title: '确定要通过这条审批吗？',sure: (s){

                          },);
                        });
                      },
                      color: Colors.blue,
                      highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtil.getInstance().setWidth(330),
                        height: 60,
                        child: Text('通过',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
                      ),
                    ),
                    padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(30)),
                  ),
                  Padding(
                    child: FlatButton(
                      onPressed: (){
                        showDialog(context: context,builder: (context){
                          return ConfirmPop(type: 1,title: '确定要驳回这条审批吗？',sure: (s){
                          },);
                        });
                      },
                      color: Colors.blue,
                      highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtil.getInstance().setWidth(330),
                        height: 60,
                        child: Text('驳回',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
                      ),
                    ),
                    padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(30)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 10,
            bottom: 100,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemBuilder: (context,index){
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: ScreenUtil.getInstance().setWidth(200),
                            padding: EdgeInsets.only(left: 10),
                            constraints: BoxConstraints(
                                minHeight: 50
                            ),
                            child: Text(detailList[index].title),
                          ),
                          Container(
                            width: ScreenUtil.getInstance().setWidth(500),
                            padding: EdgeInsets.only(left: 10),
                            child: Text(detailList[index].content),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        color: RGB(r: 245,g: 245,b: 245),
                      )
                    ],
                  );
                },
                itemCount: detailList.length,
              ),
            ),
          ),
        ],
      )
    );
  }
  updateListWithHeTong(HeTongModel model) {
    setState(() {
      detailList = [
        DetailListItem(title: '企业名称：',content: model.first.toString()),
        DetailListItem(title: '部门名称：',content: model.deptname),
        DetailListItem(title: '合同编号：',content: model.bgncode),
        DetailListItem(title: '合同名称：',content: model.bgnname),
        DetailListItem(title: '合同金额：',content: model.bgnvalueStr),
        DetailListItem(title: '税率(%)：',content: model.shuilv),
        DetailListItem(title: '结算方式：',content: model.jsfs.toString()),
        DetailListItem(title: '合同类别：',content: model.bgntype),
        DetailListItem(title: '签订时间：',content: model.signdate),
        DetailListItem(title: '对方单位名称：',content: model.second),
        DetailListItem(title: '签订事由及内容：',content: model.remark),
      ];
    });
  }
  updateListWithHR(HRModel model) {
    setState(() {
      detailList = [
        DetailListItem(title: '申请人：',content: model.username),
        DetailListItem(title: '申请时间：',content: model.applydate),
        DetailListItem(title: '申请天数：',content: model.applydays),
        DetailListItem(title: '申请类型：',content: model.typename),
        DetailListItem(title: '开始时间：',content: model.startdate),
        DetailListItem(title: '结束时间：',content: model.enddate),
        DetailListItem(title: '申请原因：',content: model.reason),
        DetailListItem(title: '备注：',content: model.ramark),
      ];
    });
  }
  updateListWithFenBao(FenBaoModel model) {
    setState(() {
      detailList = [
        DetailListItem(title: "分包编号：",content: model.subplancode),
        DetailListItem(title: "工程编号：",content: model.projectcode),
        DetailListItem(title: "工程名称：",content: model.projectname),
        DetailListItem(title: "任务编号：",content: model.taskcode),
        DetailListItem(title: "任务名称：",content: model.taskname),
        DetailListItem(title: "项目类别：",content: model.itemname),
        DetailListItem(title: "施工单位：",content: model.comname),
        DetailListItem(title: "施工负责人：",content: model.remark),
        DetailListItem(title: "预算金额：",content: model.planvalueStr),
        DetailListItem(title: "分包类型：",content: model.subtype),
        DetailListItem(title: "集体讨论人员：",content: model.peoples),
        DetailListItem(title: "集体讨论组织者：",content: model.org),
        DetailListItem(title: "分包结算方式：",content: model.fbjiesuantype),
        DetailListItem(title: "集体讨论理由：",content: model.jttlly),
        DetailListItem(title: "集体讨论确定分包单位理由：",content: model.reason),
      ];
    });
  }
  updateListWithZhaoBiao(FenBaoModel model) {
    setState(() {
      detailList = [
        DetailListItem(title: "分包编号：",content: model.subplancode),
        DetailListItem(title: "工程编号：",content: model.projectcode),
        DetailListItem(title: "工程名称：",content: model.projectname),
        DetailListItem(title: "任务编号：",content: model.taskcode),
        DetailListItem(title: "任务名称：",content: model.taskname),
        DetailListItem(title: "招标名称：",content: model.zbname),
        DetailListItem(title: "分包类型：",content: model.subtype),
        DetailListItem(title: "分包结算方式：",content: model.fbjiesuantype),
        DetailListItem(title: "暂定招标金额：",content: model.planvalueStr),
        DetailListItem(title: "最低投标让利率：",content: model.lowRllv),
        DetailListItem(title: "费率(%)：",content: model.feilv),
        DetailListItem(title: "拟分包项目工程量：",content: model.subcontent),
        DetailListItem(title: "限价要求：",content: model.xianjia),

      ];
    });
  }
}

//-----------------列表类的详情展示---------------
class WuZiListDetail extends StatefulWidget {
  final String pageUrl;
  final int id;
  final MenuType type;
  WuZiListDetail({this.pageUrl,this.id,this.type});
  @override
  WuZiListDetailState createState() => WuZiListDetailState();
}

class WuZiListDetailState extends State<WuZiListDetail> {
  List<WuZiModel> detailList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData() async {
    String url = '/workflow/' + ZSTool.getInstance().base64Encode(widget.pageUrl) + '/' + widget.id.toString();
    await ZSHttp.getInstance().get(url: url,callBack: (r){
      print(url);
      print(r);
      if (r.data['maRecede'] != null) { //
        Map<String, dynamic>data = r.data['maRecede'];
        appendList(data);
      }
      else if (r.data['maApply'] != null) { //
        Map<String, dynamic>data = r.data['maApply'];
        appendList(data);
      }
      else if (r.data['maFetch'] != null) { //
        Map<String, dynamic>data = r.data['maFetch'];
        appendList(data);
      }
    });
  }
  appendList(data){
    List<dynamic> list = data['list'];
    List<WuZiModel> models = [];
    list.forEach((item){
      WuZiModel m = WuZiModel.fromJSON(item);
      models.add(m);
    });
    setState(() {
      detailList = models;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.type.title),
          elevation: 0,
        ),
        backgroundColor: RGB(r: 245,g: 245,b: 245),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 100,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      child: FlatButton(
                        onPressed: (){
                          showDialog(context: context,builder: (context){
                            return ConfirmPop(type: 0,title: '确定要通过这条审批吗？',sure: (s){

                            },);
                          });
                        },
                        color: Colors.blue,
                        highlightColor: Colors.blue[700],
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: 60,
                          child: Text('通过',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
                        ),
                      ),
                      padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(30)),
                    ),
                    Padding(
                      child: FlatButton(
                        onPressed: (){
                          showDialog(context: context,builder: (context){
                            return ConfirmPop(type: 1,title: '确定要驳回这条审批吗？',sure: (s){
                            },);
                          });
                        },
                        color: Colors.blue,
                        highlightColor: Colors.blue[700],
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: 60,
                          child: Text('驳回',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)),
                        ),
                      ),
                      padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(30)),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 10,
              bottom: 100,
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context,index){
                    if (index == 0) {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: ScreenUtil.getInstance().setWidth(250),
                                constraints: BoxConstraints(
                                    minHeight: 50
                                ),
                                child: Text('编号',style: TextStyle(fontSize: 17,color: Colors.blue,fontWeight: FontWeight.bold),),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: ScreenUtil.getInstance().setWidth(250),
                                constraints: BoxConstraints(
                                    minHeight: 50
                                ),
                                child: Text('名称',style: TextStyle(fontSize: 17,color: Colors.blue,fontWeight: FontWeight.bold),),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: ScreenUtil.getInstance().setWidth(250),
                                constraints: BoxConstraints(
                                    minHeight: 50
                                ),
                                child: Text('数量',style: TextStyle(fontSize: 17,color: Colors.blue,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          Container(
                            height: 1,
                            color: RGB(r: 245,g: 245,b: 245),
                          )
                        ],
                      );
                    }
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: ScreenUtil.getInstance().setWidth(250),
                              padding: EdgeInsets.all(10),
                              constraints: BoxConstraints(
                                  minHeight: 50
                              ),
                              child: Text(detailList[index-1].matcode),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: ScreenUtil.getInstance().setWidth(250),
                              padding: EdgeInsets.all(10),
                              constraints: BoxConstraints(
                                  minHeight: 50
                              ),
                              child: Text(detailList[index-1].matname),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: ScreenUtil.getInstance().setWidth(250),
                              padding: EdgeInsets.all(10),
                              constraints: BoxConstraints(
                                  minHeight: 50
                              ),
                              child: Text(detailList[index-1].amount),
                            ),
                          ],
                        ),
                        Container(
                          height: 1,
                          color: RGB(r: 245,g: 245,b: 245),
                        )
                      ],
                    );
                  },
                  itemCount: detailList.length + 1,
                ),
              ),
            ),
          ],
        )
    );
  }
}

//------------------任务------------------------
class RenWuDetail extends StatefulWidget {
  @override
  RenWuDetailState createState() => RenWuDetailState();
}

class RenWuDetailState extends State<RenWuDetail> {
  List images = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('任务'),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.pushNamed(context, 'chart');
            },
            child: Container(
              child: Icon(Icons.chat),
            ),
          ),
//          FlatButton(
//            onPressed: (){
//              Navigator.pushNamed(context, 'chart');
//            },
//            child: Container(
//              child: Icon(Icons.local_airport),
//            ),
//          )
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1
          ),
          itemCount: images.length,
          itemBuilder: (context,index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Image.file(images[index]),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var img = await ImagePicker.pickImage(
            source: ImageSource.gallery
          );
          if (img != null) {
            setState(() {
              images.add(img);
            });
          }
//          var base64 = await ZSTool.getInstance().imageFile2Base64(img);
//          print(base64);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

//------------------辅助对象------------------------
class DetailListItem {
  final String title,content;
  DetailListItem({this.title,this.content});
}
