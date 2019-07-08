import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/common/config.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';
import 'package:flutter_app/common/tool/ZSHttp.dart';
import 'package:flutter_app/models/homeModel.dart';
import 'package:flutter_app/home/detail.dart';
class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  Map<String,dynamic> typeData;
  List<HomeMenu> headerMenus = [];
  HomeMenu selectedMenus;
  List<SearchListModel> searchList = [];
  int page = 1;
  @override
  Widget build(BuildContext context) {
    if (typeData == null) {
      typeData = ModalRoute.of(context).settings.arguments;
      getHeaderData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(typeData['type'].title),
        elevation: 0,
      ),
      body: RefreshIndicator(child: ListView.builder(
        itemCount: searchList.length + 1 + 1,
        itemBuilder: (BuildContext context,int index) {
          if (index == 0) {
            return SearchHeader(type: typeData['type'],
                headerMenus: headerMenus,
                selectedMenus: selectedMenus,
                callBack: (){
                  showSelected(context);
                },
            );
          }
          if (index == searchList.length + 1) {
            if (searchList.length > 0) {
              page += 1;
              search();
            }
            return Container(
              alignment: Alignment.center,
              child: Text('上拉加载数据'),
            );
          }
          return GestureDetector(
            child: SearchCell(type: typeData['type'],model: searchList[index-1]),
            onTap: (){
              SearchListModel model = searchList[index-1];
              if (typeData['type'].searchVCType == UISearchVCType.wuzi) {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return WuZiListDetail(pageUrl: selectedMenus.pageurl,id: model.id,type: typeData['type']);
                }));
              }
              else if (typeData['type'].searchVCType == UISearchVCType.renwu) {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return RenWuDetail();
                }));
              }
              else {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return BaseDetail(pageUrl: selectedMenus.pageurl,id: model.id,type: typeData['type']);
                }));
              }
            },
          );
        },
      ), onRefresh: () async {
        await search();
      }),
    );
  }
  getHeaderData() async {
    await ZSHttp.getInstance().get(url: '/menu/' + ZSTool.getInstance().base64Encode(typeData['pageurl']), callBack: (r){
      List<dynamic> sub = r.data['submenus'];
      List<HomeMenu> menus = [];
      sub.forEach((item){
        var model = HomeMenu.fromJSON(item);
        menus.add(model);
      });
      setState(() {
        headerMenus = menus;
        if (menus.length > 0) {
          selectedMenus = headerMenus[0];
        }else {
          selectedMenus = HomeMenu(pageurl: typeData['pageurl']);
        }
      });
      search();
    });
  }
  search() async {
    MenuType type = typeData['type'];
    Map<String, dynamic> params = {
    };
    type.searchInputs.forEach((searchInput){
      params[searchInput.paramKey] = searchInput.content;
    });
    params['page_size'] = kNumberOfPage;
    params["page_num"] = page;
    await ZSHttp.getInstance().get(url: '/workflow/' + ZSTool.getInstance().base64Encode(selectedMenus.pageurl),data: params,callBack: (r){
      List<dynamic> sub = r.data['list'];
      List<SearchListModel> list = [];
      sub.forEach((item){
        var model = SearchListModel.fromJSON(item);
        list.add(model);
      });
      setState(() {
        if (page == 1) {
          searchList = list;
        }else {
          searchList += list;
        }
      });
    });
  }
  showSelected(context){
    showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text('选择审批类型'),
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            children: headerMenus.map((item) => ListTile(
              title: Text(item.menuname),
              onTap: () async{
                Navigator.pop(context);
                setState(() {
                  selectedMenus = item;
                });
                await search();
              },
            )).toList(),
          );
        }
    );
  }
}

class SearchHeader extends StatelessWidget {
  SearchHeader({this.type,this.headerMenus,this.selectedMenus,this.callBack});
  final MenuType type;
  final List<HomeMenu> headerMenus;
  final HomeMenu selectedMenus;
  final void Function() callBack;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: (headerMenus.length > 0 ?
      <Widget>[
        GestureDetector(
          child: Container(
            height: 60,
            width: ScreenUtil.getInstance().setWidth(750),
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            color: Colors.blue,
            child: Text(
              selectedMenus.menuname,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
              ),
            ),
          ),
          onTap: (){
            callBack();
          },
        )
      ] + type.searchInputs.map((e) => Container(
        height: 60,
        width: ScreenUtil.getInstance().setWidth(750),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        color: Colors.white70,
        child: Row(
          children: <Widget>[
            Container(
              width: 90,
              child: Text(e.title,
                style: TextStyle(
                    fontSize: 15
                ),
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(520),
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.blue,
                      width: 2
                  )
              ),
              child: TextField(
                textInputAction: TextInputAction.search,
                onChanged: (s) {
                  e.content = s;
                  print(s);
                },
                onSubmitted: (s) {
                  print('onSubmitted');
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: e.placeholder,
                    contentPadding: EdgeInsets.all(5)
                ),
              ),
            )
          ],
        ),
      )).toList()
          :
      type.searchInputs.map((e) => Container(
        height: 60,
        width: ScreenUtil.getInstance().setWidth(750),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        color: Colors.white70,
        child: Row(
          children: <Widget>[
            Container(
              width: 90,
              child: Text(e.title,
                style: TextStyle(
                    fontSize: 15
                ),
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(520),
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.blue,
                      width: 2
                  )
              ),
              child: TextField(
                textInputAction: TextInputAction.search,
                onChanged: (s) {
                  e.content = s;
                  print(s);
                },
                onSubmitted: (s) {
                  print('onSubmitted');
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: e.placeholder,
                    contentPadding: EdgeInsets.all(5)
                ),
              ),
            )
          ],
        ),
      )).toList()),
    );
  }
}

class SearchCell extends StatelessWidget {
  SearchCell({Key key,this.type,this.model});
  final MenuType type;
  final SearchListModel model;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil.getInstance().setWidth(100),
                height: ScreenUtil.getInstance().setWidth(100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(50)),
                    color: type.bgColor
                ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10),
                child: Image.asset(type.imgName),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                width: ScreenUtil.getInstance().setWidth(500),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(getTextContent(0),style: TextStyle(fontSize: 15)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(getTextContent(1),style: TextStyle(
                          color: type.searchVCType == UISearchVCType.kaoqing ?
                          RGB(r: 92,g: 212,b: 128) : RGB(r: 100,g: 100,b: 100)
                      ),),
                    ),
                    Text(getTextContent(2),style: TextStyle(color: RGB(r: 92,g: 212,b: 128)))
                  ],
                ),
              ),
              Image.asset('assets/ic_right_arrow.png'),
            ],
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(750),
            height: 2,
            color: Color.fromRGBO(245, 245, 245, 1),
          )
        ],
      ),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
    );
  }
  String getTextContent(int lineIndex) {
    if (model == null) {
      return '';
    }
    if (type.searchVCType == UISearchVCType.hetong) {
      List<String> texts = [
        '合同名称：' + model.name,
        '合同编号：' + model.code,
        '合同状态：' + model.statusstr
      ];
      return texts[lineIndex];
    }
    else if (type.searchVCType == UISearchVCType.kaoqing) {
      List<String> texts = [
        '申请人：' + model.name,
        '开始时间：' + model.start,
        '结束时间：' + model.end
      ];
      return texts[lineIndex];
    }
    else if (type.searchVCType == UISearchVCType.wuzi || type.searchVCType == UISearchVCType.renwu) {
      List<String> texts = [
        '任务名称：' + model.name,
        '任务编号：' + model.code,
        '任务状态：' + model.statusstr
      ];
      return texts[lineIndex];
    }
    else if (type.searchVCType == UISearchVCType.fenbao) {
      List<String> texts = [
        '工程名称：' + model.name,
        '工程编号：' + model.code,
        '工程状态：' + model.statusstr
      ];
      return texts[lineIndex];
    }
    return '';
  }
}

