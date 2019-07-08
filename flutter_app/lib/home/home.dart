import 'package:flutter/material.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';
import 'package:flutter_app/common/tool/ZSHttp.dart';
import 'package:flutter_app/models/homeModel.dart';
import 'package:flutter_app/common/config.dart';
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<HomeMenu> homeItems = [

  ];
  ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    getMenuData();
    super.initState();
  }

  getMenuData() async {
    await ZSHttp.getInstance().get(url: '/menu/' + ZSTool.getInstance().base64Encode('root'),callBack: (r){
      List<dynamic> sub = r.data['submenus'];
      List<HomeMenu> menus = [];
      sub.forEach((item){
        var model = HomeMenu.fromJSON(item);
        menus.add(model);
      });
      setState(() {
        homeItems = menus;
      });
//      homeItems.forEach((item){
//        print(item.pageurl);
//      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //横轴三个子widget
              childAspectRatio: 1.2 //宽高比为1时，子widget
          ),
          itemCount: homeItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('search', arguments: {
                  'pageurl': homeItems[index].pageurl,
                  'type': menus[homeItems[index].pageurl]
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: menus[homeItems[index].pageurl].bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      menus[homeItems[index].pageurl].imgName,
                      width: 50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(menus[homeItems[index].pageurl].title),
                  )
                ],
              ),
            );
          },
        ),
        onRefresh: () async {
          await getMenuData();
        },
      ),
    );
  }
}

